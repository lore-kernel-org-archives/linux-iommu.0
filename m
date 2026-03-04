Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4214A60C
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583273; cv=none; b=PejVYmJe4dtxM5vJS77czdw+J9hW/La3e1Pf7HYSGZGq+g5pSrHivW8S1SCO6u8Ar3C4WZSJcBrOdf/zpaHpIkC9xQqr11wuXhNyp8MhFkAQUeOa2Nh+D0m93D9+Ox23Pt0R03Z9M8cEL1cvYqBkR0ecrKk8ECIfcPHYO+yZ1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583273; c=relaxed/simple;
	bh=U9UXIdLU8BvUztKsPeUE+y0UZ++d8vQWu2zD6G/4zOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc6NFVstBQF58eDU7h0AH9WXnDcr1v9Kaa3RBPKpQgpEIp3e872es/QoLe9skN1wUsACtUqqArVBCTwE/sS4XoBg0fpqg6estR6OjSrIk13a6OZEayVOdmATkoaVW4wNQve0gi2sb952KTJ6xIcOV7eteF3eUc8CnLZmmn8eEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5sJoLQC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5sJoLQC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so119895ad.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 16:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772583271; x=1773188071; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9UXIdLU8BvUztKsPeUE+y0UZ++d8vQWu2zD6G/4zOs=;
        b=N5sJoLQCQ8QDErvWBKvGqepnhqaIQ+4+6lnACriCwhtrQq7TXnyAjvPdtQ3KUeBdaW
         DqKRuh4cjPc68dUh6YdDLEAdllq03uTsfdEDyRK4xj8ZIFVHlqEG4NSqjNVOWZnDyCfz
         cZBVR1mA13VSqFAIYxjz4S2Blh0MRf/1Ance3Cogx9bWST/T3t9dpboTjXsbrQky9AXr
         xRs8qDcMVg0VA6Ky6Wrl0i2pTzps+ZZCpTwD1k8nrjCQeCcpzTnzQz8WBV6nwmHJ2EGD
         ds+6RF+t/tpFyjgzzySnAYvR7xaQKOeqY/UvQ2WRSAq7hjgs67ClJqUJY/d1erPafIFH
         E/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772583271; x=1773188071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9UXIdLU8BvUztKsPeUE+y0UZ++d8vQWu2zD6G/4zOs=;
        b=fHNI1oB8zRDa/EBoR51D4BRBQRed4bDmTtqCSgyAEPSppaGNx85ovDpRpDYfT2IsoM
         ukFvEBas5JTnUvE+UjWwJI0q4JmtoZrThX4d2QTiTynZ4pTQtAWDPTy0zWnXiur08x5M
         4olVSFn6tWlmxWFPN02LvmCN5BPq+rwigBkp2r4p1nTlTZcbclaA63FjurC0awqc1mA2
         dJSojNZR8nG9Z8dQDiLMH5csgQeoJNOK3f1AGogNqqN6dAnXBxW+W+CgX4WooB+AfeDQ
         +ckS1LkzR09/pDJogfJc0yIvc1gEuDcpe43518nR0Mg8/wnhg2K2eELULZMqeg+sHRZp
         D6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtwpNnFeZHnE5iSPgz2aHcS7GA91ZoPH/2pHYQYHpZhOIaJ8hSuCLTD+IQ6TlVqNSVJguGyw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl7IEeIcklraHejbBo+xZPBlvYCl7doCnFHKhYxl4vyqrrvchu
	QbG1N0Ny40yTuJ2kHi38L3fkKg0gvPgKUXuWcgoEOK5gf/emrUfQAP1FyHX0OvKDRw==
X-Gm-Gg: ATEYQzzeI9nDD8VVChxgHtccxpYsGH1it2asXFf2z1ciruR+MqY11q9rKgk20GgUma5
	QgyCscJWm0WgEZF8biurvGMbagzKMnpWOU9KZj4dk5phVW90cuNZElogQYOVFxP9KoQ+zKJoAVv
	7kNdy3HivU13uw6hWy5d4+DJyTbdl24lLS6wFhBkeWXbyWSOkPW44icMsBhN6nNK1gB3+i1F+J1
	lj9qO65q0awcd/LMK6O53j5WkbkkJT41tXZpYw3xbqUxXHEPsU27GWfnVtr9AFrzwb+4lZ31DqC
	JIKIGKGTRxKnJha/SfQFUefi6PoBETg1X0R993wjrqpJH5cEq7fAmrmBUQp5WNIvALqL1plSDdX
	3dtz9vn6ZalWY5XACpZ/wl7nLrjtibuSA+CRAhjJrsJVnVu38xZL843G+Y2d/PG37ZjlEeFi9K7
	ELuaMzKTtvnnt4m0jETh1rkPk2gjqs4rvVc8JzcryotoOUR4T3p9JXIlLO5ZhCS+RPf1YCEFkL
X-Received: by 2002:a17:903:3848:b0:2a0:89b0:71d7 with SMTP id d9443c01a7336-2ae3b50ac0dmr8356425ad.13.1772583271061;
        Tue, 03 Mar 2026 16:14:31 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm179957995ad.45.2026.03.03.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 16:14:30 -0800 (PST)
Date: Wed, 4 Mar 2026 00:14:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	baolu.lu@linux.intel.com, kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com, 
	mochs@nvidia.com, kjaju@nvidia.com
Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
Message-ID: <icbrt7x3wfqa4wavppqevqrljra65koxun55gqjasv4cda7r57@ataukpekm7zs>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
 <p435ycx3b27d5gpzcli2kbp4eh36fq2ufgkft3hf3rqgqfx7i6@oql6hovzwkju>
 <20260303232835.GI972761@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260303232835.GI972761@nvidia.com>

On Tue, Mar 03, 2026 at 07:28:35PM -0400, Jason Gunthorpe wrote:
>On Tue, Mar 03, 2026 at 10:42:48PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
>> > PCIe ATS may be disabled by platform firmware, root complex limitations,
>> > or kernel policy even when a device advertises the ATS capability in its
>> > PCI configuration space.
>> >
>> > Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow IOMMU
>> > drivers to report the effective ATS decision for a device.
>>
>> nit: Maybe have IOMMU_CAP_PCI_ATS_SUPPORTED instead of the negative
>> variant of the capability. As this will affect only new users who might
>> check this capability so this does not really have to be negative.
>
>It is deliberately negative for UAPI reasons.
>
>Currently all userspace should assume ATS is supported.
>
>The negative means new userspace that is sensitive will still work
>correctly on old and new kernels that both return 0 as meaning ATS is
>supported.

Ah yes, for old userspace missing cap means ATS is supported.
>
>Perhaps this should be touched on in the commit message.

+1
>
>Jason
