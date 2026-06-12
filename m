Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8231034A3A5
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293958; cv=none; b=ZI9INig6mthjuIF2CVTJkSmGv/7gSVSK9vsfDzbzkuV30Xo6d5zKql3EuaPhXHyrKWDjhHvngjTLzdokYF/O4JQwFqOeElCT1anfHFQlukGD34/TxIH70w/hSM9XXzQYMmFiZ2mPHbUUu+Sw/vHPFwQj2DeifSNiVUSTdlw3Wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293958; c=relaxed/simple;
	bh=Yly7LzUgthuLqHrlDI0LmOOXFBdyVkf+DYyn4bXOPRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UhMfXIabU2rfTGsE2u2nyPvYDzz1ozY0gQLZKNqNERHGhkyx9QqkfpV1STL4yQlCPo+7vIy16KBPedjkTWDkqmSE1DjuEBtf03VJ5zKDwnINo+nudZromlFE12IlKc5eyJ1ipqADLGL6wVK+c8sUoN+iinmuwEfMfI1G3WuR6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEe1CN5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEe1CN5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781293955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRZXfFWF9iKY2a6Bx+nI5XFI0/QDokZ5tF4e29mYuZ4=;
	b=UEe1CN5N1rpCBaQn09OMa8REqxWnOSt0xG5h3MJ0lRVoiJfavdUbpgpOnc5yK7m+rJlDLO
	kD6RJEq9v36+/UloCLINSJKk/cBPkmjpB0XHw1SB6w87RwmnDL68QbxUd0hjPtIS5c/2jz
	XYI7Nc94tFSQtqvaK7dLm3qk5GShTNk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-INKd6TArOsOvkkQ7nore4Q-1; Fri, 12 Jun 2026 15:52:34 -0400
X-MC-Unique: INKd6TArOsOvkkQ7nore4Q-1
X-Mimecast-MFC-AGG-ID: INKd6TArOsOvkkQ7nore4Q_1781293953
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51776d4355cso53091971cf.0
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 12:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293953; x=1781898753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRZXfFWF9iKY2a6Bx+nI5XFI0/QDokZ5tF4e29mYuZ4=;
        b=mj1Qk54epK53p6mES8eEf/xxfnxrO7ZyrI1WfS8MlbbLxjkDW8W800/tmPes6fSoew
         yxHVmzoxv0ikUK00FBbZ7yIVgM1BOT++HAtQYYF/byr1KLMYAwH3xJWMBMVoGg2KDk8t
         KcO34gIKjVgvq94ZqZR9ytjFkNIGPhllG0aEhMETIQqchbAMlfaawywTtHQjAUS4AbJV
         WK8gmvmIKaOn9a1Vsi0WFBjrvrnQb/Pmn2I3UHmERcoymi8k0f2o9AtVz57AuwKPmZ1D
         zyv6OnqZxbbOoDCgLymRTkiQN+/24eIpfgHEGvRHGkZxQ2i+hbfBO/iVZksL4yyQQ0BC
         1+hw==
X-Forwarded-Encrypted: i=1; AFNElJ95wh38zO8++vgvZiN2Nt1W1g5VlTuPO56RdQwWZGjzNbx2iPdGrYfxevn8LZTEAQG2mJxNYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpEiJTvrRmI2XyvmTieGT5TmMkQVOPF3H8x1mbcYVcTXQY1UQA
	TKbs4hYWv5V0FlFHXFGoY8o1fNsJfiMd2X1ye3oWZ+7At0YwMMWHIeRPm103K/mMROxYStoZ3YL
	cDhZGX/fW+vL6sKI76QrGrwqo2otI3NkI91fiHiFhqmFJDpRbHQzzPQ6M
X-Gm-Gg: Acq92OEAIP/rXSv7m5z9ybxhUb0yw3MxkOJTjYyY3Y440X4X8lNr0SVyqReqxjsffB9
	A28ILxQVFg0CIejzbAQgJu8EgQWCRGa5nJQhzKvVtpP3tuNGhvN8MsdJRQqauEzhpTm5/qhy4JL
	MTJbXPcZEdpHfw1mr994ZHkqYPANaEGAqkb9xeNK2UehwxD/iNgzJQonN2z3ma8MIwa1dNxRcKk
	49XKTxw41SR/EInp1fuE+ZD6kuqtHpYNfHLZpjZ+uuwSC1dpSl/CuQmL5PTVkHu0K+vLisiTxKV
	/W5ceJHx8BmTWFMgi1YYF4B2rzIlAfryQnqdUScNa9Q2y9UVEz7VcQLL6uUVnAMlUE6/xlDsmQw
	eKwxPYhF2UgQVGtYabMeqzPQ=
X-Received: by 2002:ac8:5cd3:0:b0:517:7871:693f with SMTP id d75a77b69052e-517fbc8c7b2mr65917741cf.8.1781293953203;
        Fri, 12 Jun 2026 12:52:33 -0700 (PDT)
X-Received: by 2002:ac8:5cd3:0:b0:517:7871:693f with SMTP id d75a77b69052e-517fbc8c7b2mr65917421cf.8.1781293952642;
        Fri, 12 Jun 2026 12:52:32 -0700 (PDT)
Received: from localhost ([2600:8800:1593:b400:1e8c:ec8f:1337:fb26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6b1c5sm33140946d6.3.2026.06.12.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:52:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:52:30 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	suravee.suthikulpanit@amd.com, iommu@lists.linux.dev
Subject: Re: AMD iopt levels question
Message-ID: <aiwzB5AyEXi3SbL5@jsnitsel-thinkpadt14sgen2i.remote.csb>
References: <airgbnJLPm3tnNig@jsnitsel-thinkpadt14sgen2i.remote.csb>
 <95921d73-f108-4383-88b5-e706f10da047@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <95921d73-f108-4383-88b5-e706f10da047@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9T-9mzz1G8RXu9G9lgm2IRpKLRtWemvH1PycN-FTqRU_1781293953
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 03:22:05PM +0530, Vasant Hegde wrote:
> Hi Jerry,
> 
> On 6/11/2026 11:11 PM, Jerry Snitselaar wrote:
> > I don't recall, is there a reason amd_iommu doesn't initialize the io
> > page tables to the number of levels supported on the system?
> 
> Its because HW supports increasing level dynamically and for performance reason
> we start w/ 3 level.
> 
> > 
> > I was looking at an issue recently with an i40e controller where
> > someone had a set of them in a bond. When it would fail over to
> > another device, the device would make a request to map as part of
> > that, and the domain would transition into the 64-bit iova address
> > space. When that happens the i40e would start generating requests
> > causing io page faults to monotonically increasing addresses starting
> > at 0x0, repeatedly causing event log resets.
> 
> I didn't get the problem. Why will it start from address 0x0? Our default is  3
> level. Even when its increasing the page table level, it shouldn't hit fault for
> existing maps.
>

I don't think the 0x0 is from the iova management code, but
potentially the firmware on these controllers, and I don't think it is
generating faults from any valid dma addresses, except potentially for
permission errors. It is just into this state where it clears some
register, and it is walking the entire iova address space for the
domain. The vast majority of the callbacks are suppressed, plus the
event log needs to keep restarting, but in one of the logs it had
walked up past the 32-bit boundary with the requests before they dealt
with the system. To be clear I think the problem is with the
controller, not the iommu code. Using iommu.forcedac works around the
issue. I tried to see if I could make it happen with some other
controller, and had no luck with that. It was just a thought that
there is the window when it is doing the DTE update due to the page
level increase where the IOMMU will reject requests.

> 
> > 
> > I didn't have a system where I could reproduce with bonded group of
> > them, but I could induce the behavior of the i40e generating the dma
> > requests by doing horrible things like throwing a bunch of io at it
> > from a remote system, and then mess with ring buffer sizes for the
> > device. I was able to capture a vmcore, and near as I could tell it is
> > during a window where the DTE gets updated as part of increasing the
> > io page table levels, a UR would be sent back to the i40e in response
> > to a request, and the controller would start sending these dma
> > requests.
> > 
> > With the HATS support in the kernel now would it make sense to
> > initialize pgtable->mode to amd_iommu_hpt_level if it is set? 
> 
> Are you referring to upstream code with generic page table support?
> 
> -Vasant
> 

The dangers of looking at a downstream issue, and writing email. Sorry
about that. The original reported issue was a downstream release with
earlier code. I'd reproduced the behavior from the i40e with a build
of 7.0-rc1 at the time, but I'm verifying now if it still happens with
a current build. So with the generic_pt code it would be
cfg->starting_level. Really though this is something for Intel to look
into with that controller. Console log below to show what it looks
like when the i40e goes off the rails.

Regards,
Jerry

---

    [root@lenovo-sd535v3-04 ~]# uname -r
    7.1.0-0.rc7.260611g9716c086c8e8.50.eln157.x86_64

    start sending traffic to the system
    mess with the mtu and tx/rx ring sizes

    ...

    [ 3175.119566] i40e 0000:81:00.0 ens1f0np0: Changing Tx descriptor count from 512 to 8160.
    [ 3175.133364] i40e 0000:81:00.0 ens1f0np0: Changing Rx descriptor count from 512 to 8160
    [ 3175.264538] i40e 0000:81:00.0: Using 64-bit DMA addresses
    [ 3175.270271] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x14 flags=0x0000]
    [ 3175.281573] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x1014 flags=0x0000]
    [ 3175.292722] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x2014 flags=0x0050]
    [ 3175.303870] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x3014 flags=0x0050]
    [ 3175.315017] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x3214 flags=0x0050]
    [ 3175.326166] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x3414 flags=0x0050]
    [ 3175.337313] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x3614 flags=0x0050]
    [ 3175.410119] i40e 0000:81:00.0: VSI seid 390 Tx ring 0 disable timeout
    [root@lenovo-sd535v3-04 ~]# [ 3193.727720] i40e 0000:81:00.0 ens1f0np0: NETDEV WATCHDOG: CPU: 128: transmit queue 86 timed out 5504 ms
    [ 3193.738292] i40e 0000:81:00.0 ens1f0np0: tx_timeout: VSI_seid: 390, Q 86, NTC: 0x0, HWB: 0x0, NTU: 0x2, TAIL: 0x0, INT: 0x1
    [ 3193.750798] i40e 0000:81:00.0 ens1f0np0: tx_timeout recovery level 1, txqueue 86
    [ 3193.811965] i40e 0000:81:00.0: VSI seid 390 Tx ring 0 disable timeout
    [ 3194.033833] i40e 0000:81:00.0: VSI seid 392 Tx ring 767 disable timeout
    [ 3194.274965] i40e 0000:81:00.1: VSI seid 391 Tx ring 0 disable timeout
    [ 3194.341842] i40e 0000:81:00.1: VSI seid 393 Tx ring 767 disable timeout
    [ 3197.343334] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x3814 flags=0x0000]
    [ 3197.354485] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x4014 flags=0x0000]
    [ 3197.365633] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5014 flags=0x0000]
    [ 3197.376781] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x6014 flags=0x0000]
    [ 3197.387929] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x7014 flags=0x0000]
    [ 3197.399076] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x8014 flags=0x0000]
    [ 3197.410227] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x8a14 flags=0x0000]
    [ 3197.421376] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x9014 flags=0x0000]
    [ 3197.432523] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x9a14 flags=0x0000]
    [ 3197.443670] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0xa014 flags=0x0000]
    [ 3197.457770] AMD-Vi: IOMMU Event log restarting
    [ 3197.465917] AMD-Vi: IOMMU Event log restarting
    [ 3197.474064] AMD-Vi: IOMMU Event log restarting
    [ 3197.482210] AMD-Vi: IOMMU Event log restarting
    [ 3197.490358] AMD-Vi: IOMMU Event log restarting
    [ 3197.498504] AMD-Vi: IOMMU Event log restarting
    [ 3197.506644] AMD-Vi: IOMMU Event log restarting
    [ 3197.514793] AMD-Vi: IOMMU Event log restarting
    [ 3197.522941] AMD-Vi: IOMMU Event log restarting
    [ 3197.531086] AMD-Vi: IOMMU Event log restarting
    [ 3200.145031] i40e 0000:81:00.0: capability discovery failed, err -EIO aq_err LIBIE_AQ_RC_OK
    [ 3200.410262] i40e 0000:81:00.0: ignoring delete macvlan error on PF, err -EIO, aq_err LIBIE_AQ_RC_OK
    [ 3202.343533] amd_iommu_report_page_fault: 815972 callbacks suppressed
    [ 3202.343535] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b843014 flags=0x0000]
    [ 3202.363252] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b843814 flags=0x0000]
    [ 3202.391691] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b844014 flags=0x0000]
    [ 3202.420100] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b844814 flags=0x0000]
    [ 3202.443571] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b845014 flags=0x0000]
    [ 3202.455260] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b845814 flags=0x0000]
    [ 3202.466946] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b846014 flags=0x0000]
    [ 3202.478627] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b846814 flags=0x0000]
    [ 3202.490307] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b847014 flags=0x0000]
    [ 3202.501987] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x94b847c14 flags=0x0000]

    ... lots of event log restarts and io page fault messages ...

    [ 3242.351205] amd_iommu_report_page_fault: 802222 callbacks suppressed
    [ 3242.351206] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cb8814 flags=0x0000]
    [ 3242.386829] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cb9014 flags=0x0000]
    [ 3242.415291] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cb9814 flags=0x0000]
    [ 3242.431241] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cba014 flags=0x0000]
    [ 3242.443004] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cba814 flags=0x0000]
    [ 3242.454768] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cbb014 flags=0x0000]
    [ 3242.466529] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cbbe14 flags=0x0000]
    [ 3242.478292] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cbc014 flags=0x0000]
    [ 3242.490054] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cbc614 flags=0x0000]
    [ 3242.501821] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x53b3cbce14 flags=0x0000]
    [ 3242.529911] amd_iommu_restart_log: 1502 callbacks suppressed
    [ 3242.529912] AMD-Vi: IOMMU Event log restarting
    [ 3242.544484] AMD-Vi: IOMMU Event log restarting
    [ 3242.552667] AMD-Vi: IOMMU Event log restarting
    [ 3242.560844] AMD-Vi: IOMMU Event log restarting
    [ 3242.569018] AMD-Vi: IOMMU Event log restarting
    [ 3242.577193] AMD-Vi: IOMMU Event log restarting
    [ 3242.585368] AMD-Vi: IOMMU Event log restarting
    [ 3242.593543] AMD-Vi: IOMMU Event log restarting
    [ 3242.601719] AMD-Vi: IOMMU Event log restarting
    [ 3242.609892] AMD-Vi: IOMMU Event log restarting
    [ 3247.352164] amd_iommu_report_page_fault: 802273 callbacks suppressed
    [ 3247.352165] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d0163f814 flags=0x0000]
    [ 3247.387790] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01640014 flags=0x0000]
    [ 3247.416251] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01640814 flags=0x0000]
    [ 3247.431201] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01641014 flags=0x0000]
    [ 3247.442964] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01641814 flags=0x0000]
    [ 3247.454729] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01642014 flags=0x0000]
    [ 3247.466492] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01642814 flags=0x0000]
    [ 3247.478255] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01643014 flags=0x0000]
    [ 3247.490016] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01643814 flags=0x0000]
    [ 3247.501779] i40e 0000:81:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0011 address=0x5d01644014 flags=0x0000]


With forcedac set:

    [root@lenovo-sd535v3-04 ~]# uname -r
    7.1.0-0.rc7.260611g9716c086c8e8.50.eln157.x86_64
    [root@lenovo-sd535v3-04 ~]# ip link set ens1f0np0 mtu 9000

    start scp of iso on remote system to i40e system

    [root@lenovo-sd535v3-04 ~]# ethtool -G ens1f0np0 rx 8160 tx 8160
    [   80.033523] i40e 0000:81:00.0 ens1f0np0: Changing Tx descriptor count from 512 to 8160.
    [   80.047691] i40e 0000:81:00.0 ens1f0np0: Changing Rx descriptor count from 512 to 8160
    [root@lenovo-sd535v3-04 ~]#
    [root@lenovo-sd535v3-04 ~]# cat /proc/cmdline
    BOOT_IMAGE=(hd0,gpt2)/vmlinuz-7.1.0-0.rc7.260611g9716c086c8e8.50.eln157.x86_64 root=/dev/mapper/rhel_lenovo--sd535v3--04-root ro crashkernel=2G-64G:256M,64G-:512M resume=UUID=12da0907-a209-4e4a-a294-ea9a06817efe rd.lvm.lv=rhel_lenovo-sd535v3-04/root rd.lvm.lv=rhel_lenovo-sd535v3-04/swap console=tty0 console=ttyS0,115200n81 iommu.forcedac=1

