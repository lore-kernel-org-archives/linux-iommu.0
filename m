Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E6239BB9
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920952; cv=none; b=DPqVq4UjYd74nGlVFz0PApEf8qlfUZdylmJCzsqchcitFhNQc/UdM9hZX1WcmmfGGSYsFb8REv18e9rE4ydhy200YTAOelCsj9g6pf9zKiHTS4BywQtyw2Vf+lwOwFlhu4V94TkB9AbPPbPk9NhdLQBoYYld7fKwF+BL+CJN5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920952; c=relaxed/simple;
	bh=+pPozREZYjRG+b56Z1UXPgJ+oE1nAfY+niokrtw8zLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lSOqYJcd5Mwza9qPWqfShJIbTGI68kvaUYWh6xEu1zuQRnjnJSxJVBWkn/QapakOBflA+BgtaZp55KfprAtikg8y9OWigzHyoP/0XxVE5oVvf/PGdlLCEGYQVwpIwo6YFjamnozOZJ0oZvY6Wz3aoV7UjOiC3KQPFjopwGf21dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4UkSl1Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4UkSl1Z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434ab938e37so43534545e9.0
        for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 04:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733920949; x=1734525749; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTRNLbMqJF/ydYoFMhz0iMOSPnicV3TjHc8XcohZ0to=;
        b=U4UkSl1ZaT+1nY71ORYpaixWZMPn0RATDlmTwwyVgFucpLxjcOBO1FvXzTC9Fmu8AD
         FxoCs0pJiAewWJdup18jzl5Ns98doRhGUWxzY/Lcqg3ZXsAZMzuxQ/W74Dpvz7KGbkcd
         dr8j2+J18ZOq1MVnooDGBYcb5Zq/ubOvMPmZkFd+e+fewRsH9Afvlvlnhpha5zcWdnQy
         jW731CIdgbZmp3SiL/jZcYyfJccEk7mEAdIvkduAqZ5+ZaapHUZ+Iic3TRKdoaHuuo6+
         cJVP76wrJRkrubujTahF1j/SAkOHCefldCHsqltFKd0SK0LtbOeDpvGDKjPfpFHKrTbr
         HjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733920949; x=1734525749;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTRNLbMqJF/ydYoFMhz0iMOSPnicV3TjHc8XcohZ0to=;
        b=Wy/FwnM0Tr1p8uYVjGeoFCh81b82P3NKVFwTFOGYT/D/6GbA1TYDy3f94tNRlXmgI2
         kvkOvbougWNc/zW3cerjUFWaCqoNkZkJ96OgtVtzNUw83+WeGUzp+sk3JCCUXzHiJPFW
         RXFxJbl94o7XBcPSoWih5YfsqK9qUYZ86yrq0neqW5yWEa+Z6hj1PRfIfci2qjKtf9RA
         bbWo8gBAieOYv69OKcAwT1hKfNbGyJbaEGNApC5AMKaJQu3toJzdIpzLEdIEkKAaUOFP
         rZ/ie6muBvnU07VHKAUDwNMd7uIePa56nDKDIcFGSUU5Jn3rPfWz3Lc1vGmUaUCaWytW
         AN0A==
X-Gm-Message-State: AOJu0Yy81Jse7f5sXgZ5S7iA+KY3y0d48jruHvf3FeFXgjltyHZl3VE6
	HzS8oHmO5+B+oTN5evNqivPkzkA05ztyxxUfvJBCTJHbheFBOTzjezjT+i+TLBc=
X-Gm-Gg: ASbGncuTPqv9/b5PHFY+9LxZSbrvpXAQtzXNw7h6SEwH1YSuX1sZr3fsoeKjr+KjsBU
	ACnCsiptviiML/2yhSkz1ksgFd80IqltI2gdM5Fz6uPNVK3gq2giWm1sR25OtR+fUVK8M6+K6tQ
	eFRZiRHXFTbRT3HzMMgzQmdd4YRLQqP5oYy59mriGEepyMOi0Mg8gf2smwm8lgc8pSvfZ9zEfkY
	mGI3jH5IIsqMAIOsnVa41q+EmgYkwF+X87VQCR8wigY5r695LbdM0ZiBsY=
X-Google-Smtp-Source: AGHT+IGxa69eHux3N71eIRvq5utlWrpY9uGgIWWLRmNh0jDz0+cAdy5vgruJWClOqNFwg80c0yz02w==
X-Received: by 2002:a5d:47a9:0:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-3864ce89578mr1813784f8f.3.1733920949031;
        Wed, 11 Dec 2024 04:42:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f440sm1208036f8f.17.2024.12.11.04.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:42:28 -0800 (PST)
Date: Wed, 11 Dec 2024 15:42:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/vt-d: Drain PRQs when domain removed from RID
Message-ID: <c5187676-2fa2-4e29-94e0-4a279dc88b49@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lu Baolu,

Commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from
RID") from Nov 4, 2024 (linux-next), leads to the following Smatch
static checker warning:

	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
	warn: sleeping in atomic context

drivers/iommu/intel/prq.c
    60 void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
    61 {
    62         struct device_domain_info *info;
    63         struct dmar_domain *domain;
    64         struct intel_iommu *iommu;
    65         struct qi_desc desc[3];
    66         int head, tail;
    67         u16 sid, did;
    68 
    69         info = dev_iommu_priv_get(dev);
    70         if (!info->pri_enabled)
    71                 return;
    72 
    73         iommu = info->iommu;
    74         domain = info->domain;
    75         sid = PCI_DEVID(info->bus, info->devfn);
    76         did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
    77 
    78         /*
    79          * Check and wait until all pending page requests in the queue are
    80          * handled by the prq handling thread.
    81          */
    82 prq_retry:
    83         reinit_completion(&iommu->prq_complete);
    84         tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
    85         head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
    86         while (head != tail) {
    87                 struct page_req_dsc *req;
    88 
    89                 req = &iommu->prq[head / sizeof(*req)];
    90                 if (!req->pasid_present || req->pasid != pasid) {
    91                         head = (head + sizeof(*req)) & PRQ_RING_MASK;
    92                         continue;
    93                 }
    94 
--> 95                 wait_for_completion(&iommu->prq_complete);
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a sleep.

    96                 goto prq_retry;
    97         }
    98 
    99         iopf_queue_flush_dev(dev);
               ^^^^^^^^^^^^^^^^^^^^^^^^^
flush sleeps as well.

The call tree is:

intel_mm_release() <- disables preempt with a spinlock
-> intel_pasid_tear_down_entry() <- the patch added intel_iommu_drain_pasid_prq()
   -> intel_iommu_drain_pasid_prq()

regards,
dan carpenter
