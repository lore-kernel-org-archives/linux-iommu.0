Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E323C49620
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472083; cv=none; b=k/4dOMIyD0Rsu1KxFYjjmnp4LojHq1sxllwfEuYbIBlOmVKKRaf7QJsXN0jtFVj5wUKY6Z2PHhw+cPJX6MMghET8y2eEeOw9G0vo073iffLZND6yRVzaPHTUSkHKkaUD16i1W4Jrs/HbZ++5WVo7L3dpqK2uWaCYzl1tC54XHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472083; c=relaxed/simple;
	bh=5YxsTx4fivecQwTZRhV4CuJO68e/Ktr9mSJlO3tSSDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N/eFmMsiFCRUvhHYmzamkAkmjaVTEghMHKAygc6PSeCLCFZHil8mOdHxQnn+crdLDkwSzWYrGoaFzTAdWCLKHNt38JVGjL4veE3JrTlnCsch79WDkqAHFbxltKWq58gy2mjzdtsg+Dzr1YnHsT7ED8lDlGkntBSMitL8ALtelpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470B41007;
	Fri,  1 Nov 2024 07:41:42 -0700 (PDT)
Received: from [10.57.90.209] (unknown [10.57.90.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51A263F528;
	Fri,  1 Nov 2024 07:41:10 -0700 (PDT)
Message-ID: <7c7b905c-ee00-4333-987e-0d0f0e45753f@arm.com>
Date: Fri, 1 Nov 2024 14:41:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Mentz <danielmentz@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
Content-Language: en-GB
In-Reply-To: <20241018180022.807928-2-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> Introduce `struct arm_smmu_event` to represent event records.
> Parse out relevant fields from raw event records for ease and
> use the new `struct arm_smmu_event` instead.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++++-------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 20 +++++++
>   2 files changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..2f1108e5de51 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1757,17 +1757,16 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>   }
>   
>   /* IRQ and event handlers */
> -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> +static int arm_smmu_handle_evt(struct arm_smmu_event *event)
>   {
>   	int ret = 0;
>   	u32 perm = 0;
>   	struct arm_smmu_master *master;
> -	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> -	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
>   	struct iopf_fault fault_evt = { };
> +	struct arm_smmu_device *smmu = event->smmu;
>   	struct iommu_fault *flt = &fault_evt.fault;
>   
> -	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> +	switch (event->id) {
>   	case EVT_ID_TRANSLATION_FAULT:
>   	case EVT_ID_ADDR_SIZE_FAULT:
>   	case EVT_ID_ACCESS_FAULT:
> @@ -1777,35 +1776,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (!(evt[1] & EVTQ_1_STALL))
> +	if (!event->stall)
>   		return -EOPNOTSUPP;
>   
> -	if (evt[1] & EVTQ_1_RnW)
> +	if (event->read)
>   		perm |= IOMMU_FAULT_PERM_READ;
>   	else
>   		perm |= IOMMU_FAULT_PERM_WRITE;
>   
> -	if (evt[1] & EVTQ_1_InD)
> +	if (event->instruction)
>   		perm |= IOMMU_FAULT_PERM_EXEC;
>   
> -	if (evt[1] & EVTQ_1_PnU)
> +	if (event->privileged)
>   		perm |= IOMMU_FAULT_PERM_PRIV;
>   
>   	flt->type = IOMMU_FAULT_PAGE_REQ;
>   	flt->prm = (struct iommu_fault_page_request) {
>   		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> -		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> +		.grpid = event->stag,
>   		.perm = perm,
> -		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> +		.addr = event->iova,
>   	};
>   
> -	if (ssid_valid) {
> +	if (event->ssid_valid) {
>   		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> -		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> +		flt->prm.pasid = event->ssid;
>   	}
>   
>   	mutex_lock(&smmu->streams_mutex);
> -	master = arm_smmu_find_master(smmu, sid);
> +	master = arm_smmu_find_master(smmu, event->sid);
>   	if (!master) {
>   		ret = -EINVAL;
>   		goto out_unlock;
> @@ -1817,28 +1816,48 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>   	return ret;
>   }
>   
> +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> +					struct arm_smmu_event *event)

One would kind of expect "get event from raw" to take a raw thing and 
return an event... personally I'd still just inline this in 
arm_smmu_handle_evt() itself, but otherwise something like 
arm_smmu_decode_evt() would seem a more logical and obvious name at this 
point.

> +{
> +	/* Pick out the good stuff */
> +	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> +	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> +	event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
> +	event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
> +	event->privileged = FIELD_GET(EVTQ_1_PnU, event->raw[1]);
> +	event->instruction = FIELD_GET(EVTQ_1_InD, event->raw[1]);
> +	event->s2 = FIELD_GET(EVTQ_1_S2, event->raw[1]);
> +	event->read = FIELD_GET(EVTQ_1_RnW, event->raw[1]);
> +	event->stag = FIELD_GET(EVTQ_1_STAG, event->raw[1]);
> +	event->stall = event->raw[1] & EVTQ_1_STALL;
> +	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
> +	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
> +	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> +	event->smmu = smmu;

The SMMU pointer isn't part of the raw event record... TBH I'd be 
inclined to leave it entirely separate, but if you really do want to 
hide it in the arm_smmu_event, at least keep things simple and 
initialise it outside the loop - it's not like it's ever going to change 
between events.

Thanks,
Robin.

> +}
> +
>   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   {
>   	int i, ret;
> +	struct arm_smmu_event evt;
>   	struct arm_smmu_device *smmu = dev;
>   	struct arm_smmu_queue *q = &smmu->evtq.q;
>   	struct arm_smmu_ll_queue *llq = &q->llq;
>   	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>   				      DEFAULT_RATELIMIT_BURST);
> -	u64 evt[EVTQ_ENT_DWORDS];
>   
>   	do {
> -		while (!queue_remove_raw(q, evt)) {
> -			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> +		while (!queue_remove_raw(q, evt.raw)) {
>   
> -			ret = arm_smmu_handle_evt(smmu, evt);
> +			arm_smmu_get_event_from_raw(smmu, &evt);
> +			ret = arm_smmu_handle_evt(&evt);
>   			if (!ret || !__ratelimit(&rs))
>   				continue;
>   
> -			dev_info(smmu->dev, "event 0x%02x received:\n", id);
> -			for (i = 0; i < ARRAY_SIZE(evt); ++i)
> +			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> +			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
>   				dev_info(smmu->dev, "\t0x%016llx\n",
> -					 (unsigned long long)evt[i]);
> +					(unsigned long long)evt.raw[i]);
>   
>   			cond_resched();
>   		}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1e9952ca989f..8a42d7b701fb 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -437,6 +437,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   
>   #define EVTQ_0_ID			GENMASK_ULL(7, 0)
>   
> +/* Events */
>   #define EVT_ID_TRANSLATION_FAULT	0x10
>   #define EVT_ID_ADDR_SIZE_FAULT		0x11
>   #define EVT_ID_ACCESS_FAULT		0x12
> @@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   #define EVTQ_1_RnW			(1UL << 35)
>   #define EVTQ_1_S2			(1UL << 39)
>   #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
> +#define EVTQ_1_CLASS_TT			0x1
>   #define EVTQ_1_TT_READ			(1UL << 44)
>   #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
>   #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
> @@ -771,6 +773,24 @@ struct arm_smmu_stream {
>   	struct rb_node			node;
>   };
>   
> +struct arm_smmu_event {
> +	struct arm_smmu_device		*smmu;
> +	u8				id;
> +	u8				class;
> +	u16				stag;
> +	u32				sid;
> +	u32				ssid;
> +	u64				iova;
> +	u64				ipa;
> +	u64				raw[EVTQ_ENT_DWORDS];
> +	bool				stall;
> +	bool				ssid_valid;
> +	bool				privileged;
> +	bool				instruction;
> +	bool				s2;
> +	bool				read;
> +};
> +
>   /* SMMU private data for each master */
>   struct arm_smmu_master {
>   	struct arm_smmu_device		*smmu;

