Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31C20ADF4
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644823; cv=none; b=dTLCpOoI4XRWs69tun9C2HRzlESXV+b8UIkBOiF3BK1/Iur97sLVxev1NtQQ182byKxA5BUpQ3PZgN8BsU47Cillu72YsYksPI5YNgP6DGN9aZD0G4eXHTx1MkRatr270nAXw/R6ZAOn2oEb5EzCFlxZodvaHBm2Qzmd1yTSBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644823; c=relaxed/simple;
	bh=XKkFgkLCSWFdbKZefskW2LkrSmVSPE6L7n+P2zQWiu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO6E01dl0GvS90f9P/sLjGZVmoE1Gm7QUm3aOkojzuIZlAPx0y415fqGbwYxXYuUIglZacCvVbxHGhX1EUtldbH5yFy0A4CIvqvBkjGU/BdaZHSO5MrYI/QM5nu9N0Nuini27mCtIRky42eMrl3o6PBkLO7j26tj6QP9EIbld0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVYExMiC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVYExMiC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8ac50b79so167255ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728644821; x=1729249621; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbwRwvSHBYe239f9eeGTFSi/zslcrjtlpnoAsLeqDs=;
        b=lVYExMiCHN7waMK1R6aTwAGA7vbq0uuCOxkFrqCHlah7UeEpKEEZD7FzoJ7TznkrYp
         WuzdNEq2ynkyOCrJo5PYWDNVdniih8gsiecxwWxkeMZylZUrvDH3PwdpEE0IBCQUAyFd
         BRlBPCBh+QZmIxUZW5p5PiyGppxNKHlJcBM7jgwDaew8cFGrMIMQjPkqXoJTfxubBud+
         fM6JuUeGoUEXegiosz1hGlj2x7vZgLzm4ApHHoZgruuTaEjPaP1RZHDOxyBSGez+zd2a
         /e/s90OeBqRX3ncox8A+q5oqthtsZ8m8zyokEKIJCaXBvyCDErwJJj6aUuY1oIql4WII
         MYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644821; x=1729249621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqbwRwvSHBYe239f9eeGTFSi/zslcrjtlpnoAsLeqDs=;
        b=oJONzSFipvACwFnOIHF1bHEYk2+4oVmRBr+acCxYd1WzIce+wNdbTG92m93m/K/YUt
         sNKLzdCIIH+Gf89eg+Cj5jKazen5b8XVhTU9wJO0zTd03fk1DIqjd0Z/pBgkrKeMzkqa
         /MV8CX7zjzGzMGewBZXWn5vGHgKAuoG0oOwQ39pQA/66KMZVdiL0BkIJZMyNuSFBFGba
         DDcD4Hj5lb0kBeIhkkvv2CLNRlCQmHRvBFIm8WXI3r724cHw15RD4kRqA5f1yIHiUXNr
         0/hC4RY+fMrr9R6fRIfkbKNCDU3jEv84xo+7gSPJtspX+mkCBGmiLM/Vwx71rT5v+jrk
         sJLg==
X-Forwarded-Encrypted: i=1; AJvYcCWhDgV0DynlhTWr+fCzHmgdVjS5hZAjoJUIRw4KOMquD4FfQ/4iskJ/VuXhH01sxCLNpnfVzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY1TFSkjQhtDdikCOn0jXv7CGhIgQP/plH8OFhsIuoyHDdNhzX
	/uHO46AAka9M6RljyNTXUrguipjuH33Szh8Sw9km2V2O8hznP8kt+tP7K3lmWw==
X-Google-Smtp-Source: AGHT+IFU5bxfKZVJ75mWiHkWy0Y5Ti0PcRO+nVJzxCfQNrayjYMTCqJr8+9dEeXMleyVYcAbR+/8fw==
X-Received: by 2002:a17:903:41cb:b0:1fc:548f:6533 with SMTP id d9443c01a7336-20ca19d6acamr1933795ad.3.1728644820971;
        Fri, 11 Oct 2024 04:07:00 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea449680c5sm2317805a12.85.2024.10.11.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:07:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:06:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZwkGzWSUIpuhHozl@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com>
 <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
 <ZwkB4OTUChexImZd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkB4OTUChexImZd@google.com>

On Fri, Oct 11, 2024 at 10:45:52AM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
> > On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
> > > On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
> > > > On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > > > > > The master and master_name are not that necessary to be in the
> > > > > > arm_smmu_event. I would keep both of them as local variables in
> > > > > > arm_smmu_handle_evt and pass master_name in to dump().
> > > > > 
> > > > > Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
> > > > 
> > > > Just move both out of arm_smmu_event. Keep the master_name as a
> > > > local variable like the "master". You'd just need to pass it in
> > > > to the dump(). They both are in that same handle_evt().
> > > > 
> > > 
> > > Ack.
> > > 
> > > > > > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> > > > > > 
> > > > > > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > > > > > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > > > > > no strong feeling about that.
> > > > > > 
> > > > > 
> > > > > Ack. How about `read_arm_smmu_event` :)
> > > > > Unless, we wanna follow the arm_smmu_<func> convention?
> > > > 
> > > > I think it'd be nicer if we do.
> > > > 
> > > 
> > > Ack. `arm_smmu_get_evt_from_raw` it is!
> > 
> > FWIW that sounds needlessly overcomplicated to me - the "raw" event array
> > should be a member of arm_smmu_event itself, since it seems silly to have
> > them separate with one pointing to the other when they have the exact same
> > scope and lifetime anyway. There still shouldn't need to be more than a
> > single logical step to process an evtq record into a finished
> > arm_smmu_event, just that that processing is now going to go a bit further
> > than simply le64_to_cpu().
> 
> Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
> OR do you mean we should have our own queue_parse_evt(q, &event) that
> parses out the raw event into an `arm_smmu_event` record eliminating the
> need for the `arm_smmu_read_evt_info` altogether?
> 
> Because we'd still need to store the raw event anyway since we're still
> logging the raw event.
> 
> I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
> and then use ``arm_smmu_read_evt_info` to populate other `event` fields

Based on your comment, I was thinking like the attached sample code.
LMK if you were referring to something like that?

> 
> > Thanks,
> > Robin.
> 

Thanks,
Pranjal
--------------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0636b81eef79..5845793c0a41 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1929,6 +1929,35 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu, u64 *evt,
 	event->smmu = smmu;
 }
 
+static int queue_remove_raw(struct arm_smmu_queue *q
+			    struct arm_smmu_event *event)
+{
+	int ret;
+
+	ret = queue_remove_raw(q,event->raw);
+	if (ret)
+		return ret;
+
+	/* Parse out the event fields */
+	event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
+	event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
+	event->ssid_valid = evt[0] & EVTQ_0_SSV;
+	event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
+	event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
+	event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
+	event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
+	event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
+	event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
+	event->s2 = FIELD_GET(EVTQ_1_S2, evt[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
+	event->stag = FIELD_GET(EVTQ_1_STAG, evt[1]);
+	event->stall = evt[1] & EVTQ_1_STALL;
+	event->raw = evt;
+	event->smmu = smmu;
+
+	return 0;
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int ret;
@@ -1941,9 +1970,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
-		while (!queue_remove_raw(q, evt)) {
+		while (!queue_remove_evt(q, &event)) {
 
-			arm_smmu_get_event_from_raw(smmu, evt, &event);
 			ret = arm_smmu_handle_evt(&event);
 			if (!ret || !__ratelimit(&rs))
 				continue;
