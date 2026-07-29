Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD042C4F4
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344466; cv=none; b=DqGMadypKefBZbwqQDxJri8QaaZ0uht0U1zOdieVzqRNZhn1BaOEU/BTEzqDZNOsXs2+MtsDgHkGug9pGLTDIV7a5rLX0gZbUeUAUw5AX1Rch7BmRFcBDRfqnb11WV5DSirtw5/KwKyqH6XGyAs63Rz8JXtUZXxqenSKCKKYHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344466; c=relaxed/simple;
	bh=fSOZJ17rVEbG+FfK1DiMh3qgkRdHa+C33+C3HyGA1Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoQGT4AmHGxd9lALeIj6zsLzsWnujwk2Crw5ou7x1nomExaNd2K/kg5nJ/HL/Zuj6TEOXvxS/agvz+RIXtvdoDRfKWOOqLn6llASbnnzzC86XnGI3CICnn5HleI33+xBOuVIc6sh3PzR/2pPzXtxCxmbqqiRAO2znHVp5NLJ7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doAa/acR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doAa/acR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso3405ad.0
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785344463; x=1785949263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtT0ExTXo5bL6h0YkCoaVWGGXnkWOHvTo5L6MU1yaIQ=;
        b=doAa/acRi0KS1pZdjaaZMhWrVu+t81qzmRgnJdnTTwb3EyC3JX+YwIZwma/332KAfd
         UPky0oyNY3U3f48/W7dCD7Fxf1eiGhUJWh0ogFLQYwwCbHju1X7CY0e3KgPhJ3B4NOiK
         +wQMqjih/1mZ6ZdpsZOaHcGJKxIbWCF/JcqgJ7wWKvhxtDUX4DQXBUoxOVKOAlkY+/gQ
         tdBKqBujHgUMiW9wVJYAe4gJsuk2loW59qgznYm1pmL316Ox9lmTbT97SaQZSMMaaa26
         Qjzlgs1psNT/Ukwo9eeTCMu09D25TVHtgxr18jTjrdxACGCyL/VXxa58qPFqtj+Ii++N
         dcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344463; x=1785949263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtT0ExTXo5bL6h0YkCoaVWGGXnkWOHvTo5L6MU1yaIQ=;
        b=CQI67fgceYN32i+zOIaGtZwaXAaBhu0c0c+DZGn0j2zJOVbc17jCDfMpzJp3/2Wvrk
         yTf4GJk8iCrnqMZ1oQPZTJwScE1zrEictSCu4PmMpyWl+Q4U4ETf7mNzassfoalp4L/K
         40QFXZ42OOiO7niBQKDsKEnHzjQ6qieR78KVZnx3mQRLHsYRLLbv8rctV2OcEDd37dlR
         HydforPmPJM0eq0JH6+cSzPbp228FdgXVkzC57eIBLNMpSYTBHAxkTZDmeatObOSXaYg
         ZwprLTyE5821u6jP4pUcfNO9U3L495NafyNhbWWaiRxRkrGwZNM5/lFcmTe5R4/vG2G+
         G8Jg==
X-Forwarded-Encrypted: i=1; AHgh+Rov6FVOq21IheAwPpRFkwTAizQU0rMZqSxvoKHT/baVIzeMiyHcbOS5ye4ov0y5dONAXB6IQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwwZuvremrZwBSIgioZFRWvR6epu8tTxhwCBoTTNKBx/z8HhOk
	ogBzeeJ68DPLT40tZ+C7/BRTfgzn4LL9eLYV9r5Bb6e/eh6rZXbZOEJ9ifUdNllo4g==
X-Gm-Gg: AR+sD112kM7RfaF+CELq6t6b9DQeWXJFjFBJTxrq83lp94KMSbXsMRrUGqv9YT6JdeF
	wjhqaLQqcFn5utUIfCrlYyCSNxiKcZE0rhwlfKqbQoSiMGM76vPs97y7udE0ScFP9VbQ7pL09vo
	KCXBKv6p4azzfBoraql4kgNeWrcOuM6NJuGN3ROZ2OIhuEikWGJDKNPUlKlDJ80cA7RLHp8d8T1
	Fz0yyBdUhqXP4vzoM/2qaGqZ2XuRk9L7H9TWDmM/onvLMIF9Pq6Sj0BhjesFZDs9CPrzWEq6dL2
	j9MMJcb0k30qzxLo7r9cayAMCR4QfVrwMwavR4tGZK6esY3F63zr5p3KvCG1KrTdJVUhLXT9FHf
	sehq8f52K1p1LedBNyA2voJOWsDuAS6pghcok/uS3xGlBC094CPnDKRjSiT9v1XSaRCX7AV+/kD
	weNKMgpbCoKEUtVwDvCZDvGYF78PisUNoXT37OmXdravFPG4W4Lg/ZlJgF438EKB5F5kTgwqcY2
	NdOiq4ozxdBYI53WPW10rQ=
X-Received: by 2002:a17:902:f608:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d03210f8c4mr355465ad.1.1785344461607;
        Wed, 29 Jul 2026 10:01:01 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0051591sm1750258b3a.19.2026.07.29.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:01:01 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:00:48 +0000
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
Message-ID: <amoxwA6EPeW1uuIp@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
 <ammMf5z-Gl-Wygk6@google.com>
 <ammO+4W/dGC8kTCr@nvidia.com>
 <ammTr2kvjpiOHkbT@google.com>
 <amousSY6qMX3felk@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amousSY6qMX3felk@nvidia.com>

On Wed, Jul 29, 2026 at 09:47:45AM -0700, Nicolin Chen wrote:
> On Wed, Jul 29, 2026 at 05:46:23AM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 28, 2026 at 10:26:19PM -0700, Nicolin Chen wrote:
> > > On Wed, Jul 29, 2026 at 05:15:43AM +0000, Pranjal Shrivastava wrote:
> > > > For PRIQ/EVTQ, my only worry was the HW producing more events,
> > > > say Device A is detached (we call drain from attach_release) but Device B
> > > > (still attached) starts an agressive DMA with multiple PRI requests/evts.
> > > > 
> > > > Maybe we should go back to snapshot based polling for that?
> > > 
> > > If you look closely, "pending" is the snapshot, regardless of the
> > > growing prod.
> > > 
> > >  * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
> > >  * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
> > >  *
> > >  *   cons0                cons                 prod0         (prod)
> > >  *     |<---- drained ---->|                     |             |
> > >  *  ---+###################+=====================+=============+--->
> > >  *     |<--------------- pending --------------->|
> > > 
> > 
> > Right, but we write back cons to cons_reg only after we see queue_empty()
> > We have a do { .. } while (!queue_empty(llq)); and then we call
> > queue_sync_cons_ovf(q). Same  for PRIQ handler.
> > 
> > IIUC the helper relies on cons_reg being updated:
> > 
> > cons = readl_relaxed(q->cons_reg);
> > drained += Q_POS(&q->llq, cons - prev);
> > 
> > Thus, if we get a storm of pri reqs / evts, we may never leave that loop
> > and queue_sync_cons_ovf(q).
> 
> cons_reg is updated by queue_remove_raw() every iteration inside
> that loop.
> 
> queue_sync_cons_ovf() doesn't update cons_reg unless an overflow.
> 

Ahh right, I was too focused on the storm *facepalm*. In that case the
new helper LGTM.

Thanks,
Praan
