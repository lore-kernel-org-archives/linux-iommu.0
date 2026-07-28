Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EDD3D954D
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273420; cv=none; b=s5R4wqkBRvQZ1q00+5/JjhFt2T5KRw51hK9HFn9LlqrLlNA2g+anytRiCLMX/7o23dFN20aaTbXFh7EcdKcDG8m3imtJePjBj8txyjLTyredr9UQefdxhWi7lxFlLotTY245kIl8cA91dccEzQEe1fXBK72B1w3iYL1d7hAD1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273420; c=relaxed/simple;
	bh=rYYKfO7fr8tCeIBgfW8VCHWFR3LOeVGgcB0gu3vWhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrYuEYZB9mg/ODy/oi06g07uA+gqCQZnpYfha9ncdN8Lw0gY7qTwu0pV5v6BVa2Eu8XRP86afA2khrnvcvLtnNIeMrdtxX3pJsvArROwBhYbE0bDtDhWmqvuR4XxAa9orfPdkph25+uWoLgjXhRV4otdmmIdVZ5zXoFku9aq/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1KmcdkH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1KmcdkH"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacef7d299so15365ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785273418; x=1785878218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QYFlnlGtzGaTmpuO49iDLUfMpOme9Z4x8j8IG4rbPjY=;
        b=L1KmcdkHOKCVhn0RITaCEH9n5dOzFxAh7KIv5ebjW7ZqBXejZX//7c6ppZI1vGq8Zt
         gIdwUeD81K4WiXAZ6hz0Lx0V7B1VQOjge5FFzY/U3WFYedB+YTI1QHB8JWj4F87giq+/
         rKrxl7t10glruAYnB/W2iP/aGRsovV5C8GnLQ9Ru8Y/omZffNP0qgUx96TX3thTMa7bO
         KMp6Y5LqSUsEFmw5QR09asiYM7PkKsQcQOyOP198/c/ncDWdSRe/WDzKBk9dFq5kl/8v
         bDzmTAu2z9rNzOSkixgjHFQXxOammsRLNnkdKRL3zGbwliZr0zp9Yk7YVQzUBZirDOZI
         E9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273418; x=1785878218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYFlnlGtzGaTmpuO49iDLUfMpOme9Z4x8j8IG4rbPjY=;
        b=AS9k0oj1meJqWpIuxX09X090QkA6IPyc3xqyYskZRckt/eRUlLiw57stjjJkFhOJUL
         wkZcXjlgcaBjxs4aqJSsmdIwHoCC2rVjy6U95AVMLZBRM5iDk/LqFXMTX1tUK1ceUcE9
         4KGus1F81tSK3KHF7c159eyCK2r32TpBYevLNfXE49Lo0QvQg9ow1Y/rkczhdEAHOAaW
         nv+c5eQBfbDKXwf4w4NS/17ikl0EjtYdVZgPadikxGT8bfflDBtrfbgGBgnmlIBDjMch
         2mW5PZR4irEM6IJSVTAIa1jaITwzY4RdASChxWNj6oHhpox1NqkuSxqBQzfZEuBm+Qfd
         8apQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFEv1hqnjVYQwZyiZ4fQgOPo9d4gh58QJaAkwSnxOz8BykfI1tLByzpA98cWNmapQOWtQVLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAzIbHK01KOi1MKWE7o62M7NrTCVItQNIg86+nQgiprKpYv2+L
	TbSuy8ubKlerQckngPc+lal4TEfxXqvDn4qxnZp9CcICgcAmsR+7GMJWH1N5WJwP1Q==
X-Gm-Gg: AR+sD127OTHHHRYAzeu6aagaYLzT/OrCSbSq5uY3OQXEqDrRr6yxX53IPMbQjkOATTb
	1LKtI8tZglCLsVHCKKDMTNYMoTtifys4Z8de0q1C/sf7ma9U3aGUXIU7BHWG9mQwGuugAF88Tqy
	uxW4szapUYzCEoeKBN1I4/WseuJXIzDAXTv3T3Jz2shihbTQ9GWU/JSsNA2NjW35oNM8Z0cAh8W
	5EWBqljfEB0DiInwxkphZfaCXjsT03JoQ/jAm6QQZPOL+7c0Fk5pbXktGVqUzHQkDgtOUnfagwg
	TkTJ9GA0CGhGfyZoArSD+BHjdCrVRitf7FvBcRPgpTlbW38frF19XLpRNaNKEUEqFmp1NV+Sk9M
	xVs5sDoBlIQoa8gmNLtygHb9LNYAgr8RH6ovaYSBioQuL/aMcTrV6fHmZSG9/LkkOImZYxqEhdo
	Ti35dnUkXi0DLa1jL+FlcULEAyr3hUri3/tEAjtArMlrhJsO0pXtK4Hc1MbsQ6TthNo5cbEkBFo
	cwoIWwUblTaFgE0UwEPfO4=
X-Received: by 2002:a17:903:1a03:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2cfde09f0damr13311135ad.3.1785273417527;
        Tue, 28 Jul 2026 14:16:57 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c2d5a4sm1779895ad.71.2026.07.28.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:16:56 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:16:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <amkcQRVylEe_t-yP@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>

On Thu, May 28, 2026 at 12:59:31AM -0700, Nicolin Chen wrote:
> A poll-until-empty form does not converge on the shared EVTQ or PRIQ since
> other masters keep advancing PROD with unrelated traffic. A fixed snapshot
> bounds the wait even under sustained unrelated load, since the target does
> not move with subsequent enqueues.
>

[...]

> 
> This is a prerequisite to apply bug fix calling iopf_queue_flush_dev().
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index cf41b3cf5985f..4794a15f351c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -894,6 +894,33 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  					   cmds->num, true);
>  }
>  
> +/* Drain an SMMU EVTQ or PRIQ to a PROD snapshot taken on entry */
> +static int arm_smmu_drain_queue_for_iopf(struct arm_smmu_device *smmu,
> +					 struct arm_smmu_queue *q)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	u32 prod, cons;
> +	int ret = 0;
> +
> +	/* Snapshot PROD; entries [old_cons, prod) are the cohort to drain */
> +	prod = readl_relaxed(q->prod_reg);
> +	queue_poll_init(smmu, &qp);
> +	qp.wfe = false; /* No SEV on EVTQ/PRIQ PROD advance */
> +	/* Read MMIO each iteration; llq->cons is the threaded handler's */
> +	do {
> +		cons = readl_relaxed(q->cons_reg);
> +		if (__queue_empty(&q->llq, cons, prod) ||
> +		    __queue_consumed(&q->llq, cons, prod))
> +			return 0;
> +		cond_resched();
> +	} while (!(ret = queue_poll(&qp)));
> +
> +	dev_warn_ratelimited(smmu->dev,
> +			     "queue drain timed out at prod=0x%x cons=0x%x\n",
> +			     prod, cons);
> +	return ret;
> +}
> +
>  static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
>  				   struct iommu_page_response *resp)
>  {

Hi Nicolin,

The following is a unified drain_queue helper, that also attempts to
address Sashiko's concerns. This applies on top of my runtime PM v9
series [1], please see if it works for you:

Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue()  helper

Introduce a unified arm_smmu_drain_queue() helper to replace queue
specific polling loops. The helper handles both snapshot-based cohort
draining (for IOPF) and full queue draining (required for Runtime PM).

The Runtime PM explicitly gates the CMDQ (via CMDQ_PROD_STOP_FLAG) prior
to draining, this allows a single, snapshot-based target to natively
handle all drain scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 68 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 +-
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9106ffb75f7a..2deed6e3bf9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1057,39 +1057,70 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 cons, u32 target)
+{
+	if (cons == target)
+		return true;
+	if (Q_WRP(q, cons) == Q_WRP(q, target))
+		return Q_IDX(q, cons) > Q_IDX(q, target);
+	return Q_IDX(q, cons) < Q_IDX(q, target);
+}
+
 /*
- * Currently, only used for CMDQ.
- * TODO: Update to handle PRIQ & EVTQ when PRI support is added
+ * Drains a queue until the consumer reaches the provided 'prod' snapshot.
+ * For CMDQ, the consumer is the SMMU hardware (polled via MMIO).
+ * For EVTQ/PRIQ, the consumer is the CPU IRQ thread (polled via software llq).
  */
-int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
-				    struct arm_smmu_queue *q)
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, u32 prod)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_ll_queue *llq = &q->llq;
-	int ret = 0;
+	/* Secondary CMDQs don't support WFE*/
+	bool is_cmdq = (q == &smmu->cmdq.q);
+	u32 cons;
 
 	queue_poll_init(smmu, &qp);
+	qp.wfe = is_cmdq;
+
+	do {
+		if (is_cmdq) {
+			cons = readl_relaxed(q->cons_reg);
+			WRITE_ONCE(q->llq.cons, cons);
+		} else {
+			cons = READ_ONCE(q->llq.cons);
+		}
+
+		if (queue_consumed(&q->llq, cons, prod))
+			return 0;
+
+		cond_resched();
+	} while (!queue_poll(&qp));
 
 	/*
-	 * The events are only generated when CMDQ becomes non-full.
-	 * Thus, wfe can't be used here, mark it false explicitly.
+	 * Check once more after timeout: cond_resched() could have delayed us
+	 * until after the timer expired while the consumer finished draining.
 	 */
-	qp.wfe = false;
-
-	do {
-		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
-		if (queue_empty(llq))
-			break;
+	if (is_cmdq) {
+		cons = readl_relaxed(q->cons_reg);
+		WRITE_ONCE(q->llq.cons, cons);
+	} else {
+		cons = READ_ONCE(q->llq.cons);
+	}
 
-		ret = queue_poll(&qp);
+	if (queue_consumed(&q->llq, cons, prod))
+		return 0;
 
-	} while (!ret);
+	dev_warn_ratelimited(smmu->dev,
+			     "queue drain timed out at prod=0x%x cons=0x%x\n",
+			     prod, cons);
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
 static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 {
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	u32 target;
 	int ret;
 
 	/*
@@ -1097,7 +1128,8 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 	 * from contexts (like suspend) where the caller has already
 	 * ensured that new command submissions are fully closed.
 	 */
-	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+	target = atomic_read(&cmdq->q.llq.atomic.prod) & CMDQ_PROD_IDX_MASK;
+	ret = arm_smmu_drain_queue(smmu, &cmdq->q, target);
 
 	if (ret)
 		goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 15b5d5fad627..eddf6f41b570 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1176,8 +1176,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
-int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
-				    struct arm_smmu_queue *q);
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, u32 prod);
 
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
-- 

[1] https://lore.kernel.org/all/20260728210928.1050849-1-praan@google.com/


Thanks,
Praan
