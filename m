Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40471E4928
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643563; cv=none; b=jGkp4X7YATwo/ovPpmHKKBiWof91hfCFAn2MFroPCvilN96xXZzJ8ulk1WIktvZo29/G1jttFpIgTaTlMtwz/yN8dGxsNZUetPnhWmQAdQ+6uO8d9n1SuSnC5uJugN5m9OejwkREdAjiIQosZLxUEIRgtTVNZsV7qqxDNdeVV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643563; c=relaxed/simple;
	bh=qv3JNoZJl0YrnV2P83x8YPlkN0/oRbOhOVjBmMXM/u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6/W6nEXK38Kx9T4EOA8GPQ491p15hrvxntqG6qAvTv+Bknw0SJEmBwkwPXNZfPHa8XpX/yHgpsi5o2s99Cqv3oOEQ9mKLnuGFW+iR/6ZewghgLhNz9tgYEdy5g7DPpn8Zf5sMD+e2ujfGqwuWzGz6JsENZDKSQ0AtyV5KPhKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsEYAOVy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsEYAOVy"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca03687fdso146905ad.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728643561; x=1729248361; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hczG1j5H6joaWRi7kRSq1VCyDCmn7eRj9q3OtW6ujVE=;
        b=dsEYAOVyJawwbqzbbIwmoy/zkC5HldiSbiBon58VpiAFGy2X+I/5DTn5SbhAWxhtrP
         7kA/KTxHZeLPB0854sVQXFkuR+K30rkGqn1JzX7hcAXLZtSal/XiOAHe83BvakUAU2Vl
         Ncl82eDJhdwoDsK3vmLkmCnbQjHPV5/MM8uJxXG5700y9/3aroA+T3WajwkCeeCEvnj7
         f4bpUPNhHzN+gVuUyeJeSEpBFYK5PD2J1w0HXFWfMbEA268avufmjMs6zrU18O3gzNAm
         Dnx/fNYD7uCYKj1bUYokHRnbDamF0xDx6oqZedPn0nAk1Sxfuc4QpNnzZ7mEUN9+4ddx
         WaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643561; x=1729248361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hczG1j5H6joaWRi7kRSq1VCyDCmn7eRj9q3OtW6ujVE=;
        b=fm89/OHNaErjnJjjDlqHECv3nbjciS9csA6pKg+Zs6CoRy5kN3eNvuhanOUUNjEn+g
         sMJrnqyTuPzCdxLx3V1fugm3mdOXR4uC30N1qMyaIGOFxC88DbMuQhXdo6x0eIMj+x3p
         2XaozMvcA6ArcdANqpLc7HzLBi33hgA0IbG1bpgO7W18GX1Y301lKkgNjUW1Ms45sYig
         cFr4WNH+zWYzKNtBgU4H9X325j0OY6/mifYZ+dKoOsJYixomONnXfehO1HEB04qEUERf
         Ggb/0a/9d43tnB4uuouqjX5oNlqLEWVs+AxMhY5sKkzu1xfFbTG4gNYWoqFT7bYEm7sD
         ng3w==
X-Forwarded-Encrypted: i=1; AJvYcCWPnWiVQiTLTaguHTXjTd56H3/u80C/M+OXcJ0/8tsVSHyqxg83w+YjdMgpgRIZqGPSKx/HOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnwnjpJpAh8udD+rXRlYPjt96ddQB/k6owkR9diNkGcdYjcNt2
	K5DH/2pTaXi+U5xpQr8bj0yxv7UqzQLMsoRrKG319wa9YrCAUryTkqFWWhKFfVWCyVRE8P8kFwh
	MrA==
X-Google-Smtp-Source: AGHT+IH3zcj+eYWjBERNLF4YJ8kZJakKdt7GF06Nol1vqCeaMzwr+n9vwIno6JYqdjUHPzypmG9ePA==
X-Received: by 2002:a17:902:d4cf:b0:1ff:3b0f:d61d with SMTP id d9443c01a7336-20c9eefff3amr2391355ad.24.1728643560613;
        Fri, 11 Oct 2024 03:46:00 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaf25c8sm2339750b3a.188.2024.10.11.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:46:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:45:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZwkB4OTUChexImZd@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
 <Zv8N6yIeNXao_Yqm@google.com>
 <Zv8gW9KjTcktgve1@Asurada-Nvidia>
 <ZwjZ9txpvqd8kUdS@google.com>
 <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com>

On Fri, Oct 11, 2024 at 11:21:48AM +0100, Robin Murphy wrote:
> On 2024-10-11 8:55 am, Pranjal Shrivastava wrote:
> > On Thu, Oct 03, 2024 at 03:53:15PM -0700, Nicolin Chen wrote:
> > > On Thu, Oct 03, 2024 at 09:34:35PM +0000, Pranjal Shrivastava wrote:
> > > > > The master and master_name are not that necessary to be in the
> > > > > arm_smmu_event. I would keep both of them as local variables in
> > > > > arm_smmu_handle_evt and pass master_name in to dump().
> > > > 
> > > > Hmm, right or maybe ONLY have the master_name in arm_smmu_event?
> > > 
> > > Just move both out of arm_smmu_event. Keep the master_name as a
> > > local variable like the "master". You'd just need to pass it in
> > > to the dump(). They both are in that same handle_evt().
> > > 
> > 
> > Ack.
> > 
> > > > > > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> > > > > 
> > > > > I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> > > > > light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> > > > > no strong feeling about that.
> > > > > 
> > > > 
> > > > Ack. How about `read_arm_smmu_event` :)
> > > > Unless, we wanna follow the arm_smmu_<func> convention?
> > > 
> > > I think it'd be nicer if we do.
> > > 
> > 
> > Ack. `arm_smmu_get_evt_from_raw` it is!
> 
> FWIW that sounds needlessly overcomplicated to me - the "raw" event array
> should be a member of arm_smmu_event itself, since it seems silly to have
> them separate with one pointing to the other when they have the exact same
> scope and lifetime anyway. There still shouldn't need to be more than a
> single logical step to process an evtq record into a finished
> arm_smmu_event, just that that processing is now going to go a bit further
> than simply le64_to_cpu().

Hmm, are you suggesting something like queue_remove_raw(q, event->raw)?
OR do you mean we should have our own queue_parse_evt(q, &event) that
parses out the raw event into an `arm_smmu_event` record eliminating the
need for the `arm_smmu_read_evt_info` altogether?

Because we'd still need to store the raw event anyway since we're still
logging the raw event.

I think we can go with the former, i.e. queue_remove_raw(q, event->raw)
and then use ``arm_smmu_read_evt_info` to populate other `event` fields 

> Thanks,
> Robin.

Thanks,
Pranjal
