Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B37404B
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650887; cv=none; b=CJ0s7t+Lsn3Xr++2MI7VasRTgMux5uKRhUv75M/ebAk61oYZauuyW1qf1qT09S9GAdmt2tryxtcQ4SYNyrOWC99lY/lb/38tXMbTQ02x9au6Tsi9LI6AOdZvsYiHSks/C/hzlO1G8qxqjTGwdzzDa64gCC4defoFS6CgW8cBKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650887; c=relaxed/simple;
	bh=WBJHkOAIOJgK+2BnV+x97h2b2sFZ9ZIsoCnmjUwnje8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gESqyw39xUaZg2EA4aTRRAyO8oNRqe8zP2CiPPja98NemWIzlRvr+/AUfDEUJjFDQCj2y+SFrpc6C0/+v9kBOPGiv1xXZbm4UrgLWVVa4pj6vJyBjnZmrZngf75iUjVXMH2JBnb4C2AqDEGChe1GppYAla1ZMMufbrd31pj9rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVWDZSMd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVWDZSMd"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20260346ca1so285825ad.0
        for <iommu@lists.linux.dev>; Sun, 25 Aug 2024 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724650885; x=1725255685; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CyaQxkaHknVwUQbFH2uq0SymBlKGnQ2wNxQ/hyE15tU=;
        b=iVWDZSMd6xPsVcBNq67praAQ1LtP70qlqHxELU2I9n0Ly/n43yEsMEKmbyAwYFJBEL
         Zcj6AiH2bJWPGM0ObovMIWY7oyFBYAXh6A8iIYahBCz9v3d8Bdf+OEpbr2VLi0xA0QEL
         7XIpgMWwQLw39TSK9y6ZGqubTKRYd9xmg1SmNqkj2oA61zkBtKUUHYBl3ChDstwyyp1Z
         wppCycs7Jks7sQg58ivFMwjxnayfRaffJ5i5DyM8OVRnmpnLCb/pnBLe+IoljaM6V34E
         0D299QdtJLETaNF1nHztn5UnBttSLK+F+Znm3J7ANuv0srxaa3M9QSEaffteRByTma/f
         iZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724650885; x=1725255685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyaQxkaHknVwUQbFH2uq0SymBlKGnQ2wNxQ/hyE15tU=;
        b=vdlGNuiLLBrTJx9bAP86bBT0DqAnZmdeE7pYUHxtIhReOMeRLEDPvXG1zT1uED1CoB
         D5BtCrC1t0uGD/+E7bPCSQbx3wYM6mNBFZpPi3IqWlBzLPtGv1dkdOW0MUXn5znM9DRW
         hJ9sDE1BdAikutkH/VLLG/SgRWj+9RAn1CCDNzV4W5HL7VKc86JDB7EUk14aGBMyvOEC
         wKm8J3Spa4/Sm5gk7UWv6GIpNPu7HXD1+/x+LNMUl2iElX9zPIoUL8/S4aqufEAJxkcT
         xfrHsipagV0nA2mxLrfpXD7fGpb59/95qWcf+hzhSvBlEKJbXJBHsellJ2rGQElsy5xn
         xsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVYdCm1Sq/ng5V6oCM1jHJXLoy/fPCd4UxM+VsYxdlW85mI2JsLjGEq896TuY1a5OH/nHP9mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmzUL3ibxAMvc7LGITZTTzKBMNPEWdfzqoKAdi9Xmre9DH7rIB
	2XwKZG3lFtuLejBQsmfO+1OJPSUb4N01GemL5et/tYh8t/So321ngf1vb0KQhrok7ofLdlVAY3J
	QoA==
X-Google-Smtp-Source: AGHT+IH6aA3i1UW9XhgU7YwFRNem7Ew2RQsRLcUo6dSF9+TpNIwW3NGoANjHuYzbqYXDhAIFz5b4HQ==
X-Received: by 2002:a17:902:c781:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-203b6c31499mr3035865ad.5.1724650884953;
        Sun, 25 Aug 2024 22:41:24 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342fc340sm6932892b3a.143.2024.08.25.22.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 22:41:24 -0700 (PDT)
Date: Mon, 26 Aug 2024 05:41:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZswVewjCcxmEzuEe@google.com>
References: <20240816211722.1404070-1-praan@google.com>
 <20240823163104.GD851@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823163104.GD851@willie-the-truck>

On Fri, Aug 23, 2024 at 05:31:05PM +0100, Will Deacon wrote:
> Hi Pranjal,
> 
> On Fri, Aug 16, 2024 at 09:17:22PM +0000, Pranjal Shrivastava wrote:
> > Currently, the driver dumps the hex for a received event, improve this
> > by parsing out fields from an event for easier-to-read event records.
> > 
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 102 ++++++++++++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  10 ++
> >  2 files changed, 105 insertions(+), 7 deletions(-)
> 
> Thanks for doing this. I've got used to the useless messages we currently
> print, but this will be a tonne beter.
> 
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a31460f9f3d4..993ded10c7b1 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1783,9 +1783,102 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  	return ret;
> >  }
> >  
> > +static void arm_smmu_print_evt_record(struct arm_smmu_device *smmu, u64 *evt)
> > +{
> > +	static const char * const evts[] = {
> > +		/* Bad config events */
> > +		[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > +		[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > +		[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > +		[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > +		[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > +
> > +		/* Bad translation events */
> > +		[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > +		[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > +		[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > +		[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > +
> > +		/* Bad fetch events */
> > +		[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > +		[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > +		[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
> > +	};
> > +
> > +	static const char * const class_str[] = {
> > +		[0] = "CD",
> > +		[1] = "TTD",
> > +		[2] = "IN",
> > +		[3] = "RES",
> > +	};
> 
> You can move these arrays out of this function...
> 

Sure, will move this out.

> > +
> > +	const char *master_name = "(unassigned sid)";
> > +	struct arm_smmu_master *master;
> > +	u64 iova, ipa;
> > +	bool ssid_valid;
> > +	u32 sid, ssid;
> > +	u8 evt_id, class;
> > +	int i;
> > +
> > +	/* Pick out the good stuff */
> > +	evt_id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +	sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > +	ssid_valid = evt[0] & EVTQ_0_SSV;
> > +	ssid = ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> > +	class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> > +	iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> > +	ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
> 
> You could encapsulate this in e.g.
> 
> 	struct arm_smmu_event {
> 		u8	id;
> 		u32	sid;
> 		u32	ssid;
> 		...
> 		u64	*raw;
> 	};
> 

Ack, will push all of this into a struct and break out the reading into
a helper function.

> > +
> > +	mutex_lock(&smmu->streams_mutex);
> > +	master = arm_smmu_find_master(smmu, sid);
> > +	if (master)
> > +		master_name = dev_name(master->dev);
> > +	mutex_unlock(&smmu->streams_mutex);
> > +
> > +	switch (evt_id) {
> > +	case EVT_ID_BAD_SID_CONFIG:
> > +	case EVT_ID_BAD_STE_CONFIG:
> > +	case EVT_ID_BAD_SSID_CONFIG:
> > +	case EVT_ID_BAD_CD_CONFIG:
> > +	case EVT_ID_STREAM_DISABLED:
> > +		dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
> > +				evts[evt_id], master_name, sid, ssid);
> > +		break;
> 
> and have separate dumper functions here, I think.
> 
> > +	case EVT_ID_TRANSLATION_FAULT:
> > +	case EVT_ID_ADDR_SIZE_FAULT:
> > +	case EVT_ID_ACCESS_FAULT:
> > +	case EVT_ID_PERMISSION_FAULT:
> > +		dev_err(smmu->dev, "Translation fault:\n");
> > +		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: iova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n",
> > +			    evts[evt_id], master_name, sid, ssid, iova, ipa,
> > +			    FIELD_GET(EVTQ_1_PnU, evt[1]) ? "Priv " : "Unpriv ",
> > +			    FIELD_GET(EVTQ_1_InD, evt[1]) ? "Inst " : "Data ",
> > +			    FIELD_GET(EVTQ_1_RnW, evt[1]) ? "Read " : "Write ",
> > +			    FIELD_GET(EVTQ_1_S2, evt[1]) ? "S2 " : "S1 ", class_str[class],
> > +			    ((evt_id == EVT_ID_PERMISSION_FAULT) && (class == EVTQ_1_CLASS_TT)) ?
> > +			    (FIELD_GET(EVTQ_1_TT_READ, evt[1]) ? " TTD Read" : " TTD Write")
> > +			    : "");
> 
> i.e. call arm_smmu_dump_translation_fault(&event) here.
> 

Alright, will move the printing to separate dumper functions.

> > +		break;
> > +
> > +	case EVT_ID_STE_FETCH_FAULT:
> > +	case EVT_ID_CD_FETCH_FAULT:
> > +	case EVT_ID_VMS_FETCH_FAULT:
> > +		dev_err(smmu->dev, "Unable to fetch data structure - bad fetch address\n");
> > +		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> > +				evts[evt_id], master_name, sid, ssid, ipa);
> > +		break;
> > +	}
> > +
> > +	dev_info(smmu->dev, "event 0x%02x received:\n", evt_id);
> > +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +		dev_info(smmu->dev, "\t0x%016llx\n",
> > +			 (unsigned long long)evt[i]);
> > +}
> 
> We should probably be consistent with dev_info() vs dev_err().

Ahh, I missed this, would use dev_err everywhere.

> 
> Will


I'll send out a v2 addressing these review comments.

Thanks,
Pranjal
