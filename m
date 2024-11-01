Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220821A4E9E
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473533; cv=none; b=NwJzFEeJvvPLE3j295IiN8lGVYrQ0Bu2ECD/uk5z4IPWgyZKF5wNcWIj4XqSELlpljjbuGOrdr0cmdkn2vFpHVa8bYqdfCpP4PPtqaO7SWUmOBtPqFIcqQfv/QJP2CO4iZFkpZb+RzdBtWgoJg1AQapGuRZt5U7U9BVhhKHcE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473533; c=relaxed/simple;
	bh=AmJkzKRQmeYUB46uqqBmMty5KZgoQbjRScytrFQ67uU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKgwAGfXleAKou2HVNDegRJXUSWqFpUhw0ck6ogRT7R13jGukaTfSe8QiXSnOdJ/rqMGNa+vxeEy2qg+devnztObwZZg54mzG2Fe82jAxXnyDwNAxh40A1hMjkSjJDE5h4ITs2yjed9LOeRjYbvOP+1ExKW4Ro9J0EkQAn3wN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF091007;
	Fri,  1 Nov 2024 08:05:58 -0700 (PDT)
Received: from [10.57.90.209] (unknown [10.57.90.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45CBA3F73B;
	Fri,  1 Nov 2024 08:05:27 -0700 (PDT)
Message-ID: <08498356-d892-4756-89e1-45b2654faa42@arm.com>
Date: Fri, 1 Nov 2024 15:05:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
Content-Language: en-GB
In-Reply-To: <20241018180022.807928-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-18 7:00 pm, Pranjal Shrivastava wrote:
> Currently, the driver dumps the raw hex for a received event record.
> Improve this by leveraging `struct arm_smmu_event` for event fields
> and log human-readable event records with meaningful information.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
>   2 files changed, 113 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f1108e5de51..4477cf86cb8e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>   	{ 0, NULL},
>   };
>   
> +static const char * const event_str[] = {
> +	/* Bad config events */
> +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> +
> +	/* Bad translation events */
> +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> +
> +	/* Bad fetch events */
> +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> +	[EVT_ID_MAX] = NULL,

"(null)" is not a particularly obvious or helpful description of an 
unknown/imp-def event.

> +};
> +
> +static const char * const event_class_str[] = {
> +	[0] = "CD fetch",
> +	[1] = "Stage 1 translation table fetch",
> +	[2] = "Input address caused fault ",

I'm wondering how to parse "caused fault" here, but either way it 
doesn't seem to line up with the other two descriptions.

> +	[3] = "Reserved",
> +};
> +
>   static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>   				    struct arm_smmu_device *smmu, u32 flags);
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
>   	return rb_entry(node, struct arm_smmu_stream, node)->master;
>   }
>   
> +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> +{
> +	int i;
> +	struct arm_smmu_device *smmu = event->smmu;
> +
> +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",

I'm mildly wary of automated parsing tools scanning for things like 
IOMMU faults, so I think it would be safest to leave any existing 
messages exactly as they are unless there's a particularly compelling 
reason to change them. And I don't believe that redundantly showing the 
same thing twice in one report is that.

Arguably more personal preference, but as before with the v2 driver, I 
also think it seems neater and more logical to show the raw data first 
in the context of the notification, and then have the decode follow as a 
clarification.

> +		event->id, event->master_name);
> +
> +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> +}
> +
> +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> +{
> +	struct arm_smmu_device *smmu = evt->smmu;
> +	char title[100] = {0};
> +	char mastr[100] = {0};
> +	char addrs[100] = {0};
> +	char flags[100] = {0};
> +	char other[50] = {0};
> +
> +	if (!__ratelimit(rs))
> +		return;
> +
> +	snprintf(title, 100, "Unexpected event received: %s\n",	event_str[evt->id]);

...that also makes it easier to avoid redundant waffle like this and 
look less like two separate things have happened.

> +	snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",

TBH I find that StreamID format even harder to read than the raw event 
record itself :/

> +		 evt->master_name, evt->sid, evt->ssid);
> +
> +	switch (evt->id) {
> +	case EVT_ID_TRANSLATION_FAULT:
> +	case EVT_ID_ADDR_SIZE_FAULT:
> +	case EVT_ID_ACCESS_FAULT:
> +	case EVT_ID_PERMISSION_FAULT:
> +		snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
> +		snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
> +		snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
> +			 evt->privileged ? "Priv | " : "Unpriv | ",
> +			 evt->instruction ? "Inst | " : "Data | ",
> +			 evt->read ? "Read | " : "Write | ",
> +			 evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
> +			 evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");

Why needlessly duplicate all the constant parts which could be in the 
format string itself?

> +		break;
> +
> +	case EVT_ID_STE_FETCH_FAULT:
> +	case EVT_ID_CD_FETCH_FAULT:
> +	case EVT_ID_VMS_FETCH_FAULT:
> +		snprintf(addrs, 100, "\tFetch address: %#llx\n", evt->ipa);
> +		break;
> +	}
> +
> +	dev_err(smmu->dev, "%s%s%s%s%s", title, mastr, addrs, flags, other);
> +	arm_smmu_dump_raw_event(evt);
> +}
> +
>   /* IRQ and event handlers */
>   static int arm_smmu_handle_evt(struct arm_smmu_event *event)
>   {
> @@ -1819,6 +1901,8 @@ static int arm_smmu_handle_evt(struct arm_smmu_event *event)
>   static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
>   					struct arm_smmu_event *event)
>   {
> +	struct arm_smmu_master *master;
> +
>   	/* Pick out the good stuff */
>   	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
>   	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> @@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
>   	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
>   	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
>   	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
> +	event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
> +	event->ttrnw_valid = false;
>   	event->smmu = smmu;
> +	event->dev = NULL;
> +
> +	if (event->id == EVT_ID_PERMISSION_FAULT)
> +		event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	master = arm_smmu_find_master(smmu, event->sid);
> +	if (master)
> +		event->dev = get_device(master->dev);
> +	mutex_unlock(&smmu->streams_mutex);
> +	event->master_name = event->dev ? dev_name(event->dev) : "(unassigned sid)";

As I said before, this shouldn't be here; we've saved the device, so we 
can derive its name at the point where we actually need its name.

Thanks,
Robin.

>   }
>   
>   static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   {
> -	int i, ret;
>   	struct arm_smmu_event evt;
>   	struct arm_smmu_device *smmu = dev;
>   	struct arm_smmu_queue *q = &smmu->evtq.q;
> @@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   		while (!queue_remove_raw(q, evt.raw)) {
>   
>   			arm_smmu_get_event_from_raw(smmu, &evt);
> -			ret = arm_smmu_handle_evt(&evt);
> -			if (!ret || !__ratelimit(&rs))
> -				continue;
> -
> -			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> -			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> -				dev_info(smmu->dev, "\t0x%016llx\n",
> -					(unsigned long long)evt.raw[i]);
> +			if (arm_smmu_handle_evt(&evt))
> +				arm_smmu_dump_event(&evt, &rs);
>   
> +			put_device(evt.dev);
>   			cond_resched();
>   		}
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8a42d7b701fb..820b08f872af 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -438,10 +438,19 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   #define EVTQ_0_ID			GENMASK_ULL(7, 0)
>   
>   /* Events */
> +#define EVT_ID_BAD_SID_CONFIG		0x02
> +#define EVT_ID_STE_FETCH_FAULT		0x03
> +#define EVT_ID_BAD_STE_CONFIG		0x04
> +#define EVT_ID_STREAM_DISABLED		0x06
> +#define EVT_ID_BAD_SSID_CONFIG		0x08
> +#define EVT_ID_CD_FETCH_FAULT		0x09
> +#define EVT_ID_BAD_CD_CONFIG		0x0a
>   #define EVT_ID_TRANSLATION_FAULT	0x10
>   #define EVT_ID_ADDR_SIZE_FAULT		0x11
>   #define EVT_ID_ACCESS_FAULT		0x12
>   #define EVT_ID_PERMISSION_FAULT		0x13
> +#define EVT_ID_VMS_FETCH_FAULT		0x25
> +#define EVT_ID_MAX			0xff
>   
>   #define EVTQ_0_SSV			(1UL << 11)
>   #define EVTQ_0_SSID			GENMASK_ULL(31, 12)
> @@ -774,7 +783,9 @@ struct arm_smmu_stream {
>   };
>   
>   struct arm_smmu_event {
> +	const char			*master_name;
>   	struct arm_smmu_device		*smmu;
> +	struct device			*dev;
>   	u8				id;
>   	u8				class;
>   	u16				stag;
> @@ -789,6 +800,8 @@ struct arm_smmu_event {
>   	bool				instruction;
>   	bool				s2;
>   	bool				read;
> +	bool				ttrnw;
> +	bool				ttrnw_valid;
>   };
>   
>   /* SMMU private data for each master */

