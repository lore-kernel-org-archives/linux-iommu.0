Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829815E7EB
	for <iommu@lists.linux.dev>; Tue,  2 Apr 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092958; cv=none; b=fNHFCWH5CpEA9Pn81mVS1b76mQ4JFQoh8+0Cyca7CwPSxnR3ejCy3C7ZBZrZAyiLX3f7RXQtNUi7VAAcgRxTzzJ7Zb7K3Q1Q+zRjBFSqBlXETmXLjcR53INlgGK6Fo8T/9hjGXbOkxhDPKUfEMuatHY1eNQxMD26rkvKbU8Q9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092958; c=relaxed/simple;
	bh=q3S2mnJx+F4UQixEHJqph9CgI4kKyg6Ln+k0xeSrGWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DziS+r56QoBZpiTNt7a5c7RLi8ieol+TuQtBaUPtVIlL4vDgNYlelrmYY1JC7EJCxQbgK7YOpHU6Y19/gIJWuh9z+HKlP7zdVBfX3iT35YhZwBdLvJ6rzXg1lNvbroTTcDx71GGHF7eKwQPuX6iQQ5Ut0p19TRb2X45Ix82ohLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWakp0Cc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWakp0Cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712092956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8hNfivdEHncz+gXdoBc2TvCcxwRvihYErqITo3fHY+Y=;
	b=YWakp0CczC9YQZT3BsxCaoUM0Ut+93Xy0CQtGC8pf/xah5l+zDRppooJ6pVvEe7/wLgrsM
	IWVIK4hhnGw0pMnBly/wvdGdNGF64lNjjwcS/yQhyZG7TQtdUohVPuq95WTt0WIBoS3Pee
	6P1rw0+XA9lUR6X9cU7V5pBv3ZJNVKM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-fPr5BQOiPmGK6pubKMU2Gw-1; Tue, 02 Apr 2024 17:22:35 -0400
X-MC-Unique: fPr5BQOiPmGK6pubKMU2Gw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69917a759b6so9344426d6.1
        for <iommu@lists.linux.dev>; Tue, 02 Apr 2024 14:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092954; x=1712697754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hNfivdEHncz+gXdoBc2TvCcxwRvihYErqITo3fHY+Y=;
        b=vg27Z/64GhSN2p6p4I3cQXKjph7/e77xNbak5NBJulh3Jm99lklsgF7qrIrpBoZXXe
         7qWyXSwECjVp8yRSgHdnZFV4fg/gqzi0Hvvc4xtaGWKjU2bCKs0WdI5uHb+R6I53kiDO
         qVD86v5WodTh7yCoW8d5L0iHI+gZQeEa2jd07q0J0y852rA6bNbgXgV9v7WRH8KjbR0D
         8dYUxFpjC5VLnZZSE38Rb/mrB9248FlyXLggY7PYsWvqtgoroJ8jJ+hkJEtFYJ4An4Vx
         VZPnzHyw4LVskNkt8Ag/voBy6j5mqxM4xlCNCXlBln9fZUsvMnCROYwqw18zS+nMgdDW
         TGfw==
X-Forwarded-Encrypted: i=1; AJvYcCUjxzWMFJTHKNZeGJrkGJrHSfAsM3Gv3zAKMYpBv1zeSNZGKdYfKAUBP8WIvYLI0kzre6+sQHG/EJ8asl0QDSJPdmj1YCM=
X-Gm-Message-State: AOJu0YzLZAgBzPx0TuHcGcvZ2l15qsYCs+EggDe8w0n49m2V47LVG6q9
	7oQYHB1Jvti+hwWaD85EckDyG2XTRpIWo6idnkQbCc0cIV0oa9XGhauQMyo0Apv4Q+NO57qi9CR
	wveZCBNBwuU4enHvSePBtRq5mt2ETMf2Y+wziHSHM807tMw2npZF+
X-Received: by 2002:a05:6214:5641:b0:696:70a0:207f with SMTP id mh1-20020a056214564100b0069670a0207fmr13472821qvb.47.1712092954417;
        Tue, 02 Apr 2024 14:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNxjYHmkw3DNwM015sO8CT5ni9l4MnhSrijQA1HDNB2Asce/Cml84DxWTD1ZKs/VhptXKAJw==
X-Received: by 2002:a05:6214:5641:b0:696:70a0:207f with SMTP id mh1-20020a056214564100b0069670a0207fmr13472804qvb.47.1712092953962;
        Tue, 02 Apr 2024 14:22:33 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id s15-20020a0562140caf00b00698fd63d167sm3591259qvs.123.2024.04.02.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:22:33 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:22:31 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-arm-msm@vger.kernel.org
Cc: robdclark@gmail.com, will@kernel.org, iommu@lists.linux.dev, 
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
Subject: sa8775p-ride: What's a normal SMMU TLB sync time?
Message-ID: <kord5qq6mywc7rbkzeoliz2cklrlljxm74qmrfwwjf6irx4fp7@6f5wsonafstt>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

Sorry for the wide email, but I figured someone recently contributing
to / maintaining the Qualcomm SMMU driver may have some proper insights
into this.

Recently I remembered that performance on some Qualcomm platforms
takes a major hit when you use iommu.strict=1/CONFIG_IOMMU_DEFAULT_DMA_STRICT.

On the sa8775p-ride, I see most TLB sync calls to be about 150 us long,
with some spiking to 500 us, etc:

    [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd start -p function_graph -g qcom_smmu_tlb_sync --max-graph-depth 1
      plugin 'function_graph'
    [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd show
    # tracer: function_graph
    #
    # CPU  DURATION                  FUNCTION CALLS
    # |     |   |                     |   |   |   |
     0) ! 144.062 us  |  qcom_smmu_tlb_sync();

On my sc8280xp-lenovo-thinkpad-x13s (only other Qualcomm platform I can compare
with) I see around 2-15 us with spikes up to 20-30 us. That's thanks to this
patch[0], which I guess improved the platform from 1-2 ms to the ~10 us number.

It's not entirely clear to me how a DPU specific programming affects system
wide SMMU performance, but I'm curious if this is the only way to achieve this?
sa8775p doesn't have the DPU described even right now, so that's a bummer
as there's no way to make a similar immediate optimization, but I'm still struggling
to understand what that patch really did to improve things so maybe I'm missing
something.

I'm honestly not even sure what a "typical" range for TLB sync time would be,
but on sa8775p-ride its bad enough that some IRQs like UFS can cause RCU stalls
(pretty easy to reproduce with fio basic-verify.fio for example on the platform).
It also makes running with iommu.strict=1 impractical as performance for UFS,
ethernet, etc drops 75-80%.

Does anyone have any bright ideas on how to improve this, or if I'm even in
the right for assuming that time is suspiciously long?

Thanks,
Andrew

[0] https://lore.kernel.org/linux-arm-msm/CAF6AEGs9PLiCZdJ-g42-bE6f9yMR6cMyKRdWOY5m799vF9o4SQ@mail.gmail.com/

