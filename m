Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4941F0988
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429483; cv=none; b=l5Ii9F0RjTTqtZmKBGrSkc3BbpdMF5da1t0eVTW3wAA4xp2j5HAomFalc8ZJ/KeXhB3R1M17HpTYV/4BnzkcyUMrpY9HnPbem3+EQHtqu+0dtVcwP+WijUDjoUkuj/jIjifv1RvNt6EGy3ldF/JIdzhED7m1wu702YJG2UYVrjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429483; c=relaxed/simple;
	bh=kgi4ELr8mCdAm9+XhEH6VRz6G3+ojfBNAMxT3w5HoSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+DecuQ8JwGYjhcXeArkgjH7XfPfyL6L3++GsgawYKQuA3z1fcQGUDKQTEnQtfUtoFXbfRx/MoGDA5yfdwYZ0UCp0xURBpVe80kDzyhV3yoPT+FPig2nHjdP1zYfAovgH7VAbjk9/HJVy3XsV7dzUcU8Fs2NOZ7FPraWa6ALaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfKJj5E/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfKJj5E/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227914acd20so11073555ad.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745429481; x=1746034281; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkDmVE1oQubncGA13yoyJE0TwJhGavatFFU357EXcEc=;
        b=tfKJj5E/UOm63gSRwwp613xBhpTVdPgotd2LGIHX98bo7vRAE6Hf0wzLWFvqpAk3oV
         o/H4XLVUCGkia95hxLC6Y3qm/DF+F72zUPgj3wgL/WklqrbdfwjyHXBOT16PcgLfQrDX
         alFlsZmslgMaiHGAAWryZEwlErKjNBtdWx2r+A6t6q2/wzi/QY/xWW8fvFl77Uqop/SJ
         WWCA9gDZSyVHjMplZoRFDHrlC96kSlSoYJrTwbabnT2bG8zcf29iWTOfdjrPB6MQjTy7
         Y6D2nYC2O4hlJFJZsXTW2I3PnRKZRTNBiRS4/QrFadxtOJOitBm9kLc1fxqwQqgm1OQX
         KyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429481; x=1746034281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkDmVE1oQubncGA13yoyJE0TwJhGavatFFU357EXcEc=;
        b=fPxqxt3F5ayoe0ALMlJr2HcFTwmItgRiKX0qDcFxE4bADjTROzjusANPDAdToDEdiC
         tfo5YLQqsrQMvzlDXTrwLnnl3Y5+5nhAQJ0mF/JSXKxX99pUPdleJQcPA6RtLy6ew0bk
         mnzYsgMuaDxAXrFzQLp9Ijjqi0PkK4pP73Hb3QK3V8VQtYQGHLpN1DwM2Nqpu9Iau5px
         T+VzKezAoJOur31v2L8fOTPPCFprFCEuNxr+Qu3stb3jijSlzT1LC1LTC7Mmy7tKdXZk
         /YoDfLR74bpvsFnzAL7kA35qCc3pYmBuGiCrxAJdKs3dmAz0af7A6FfG3ZlQ3T2v6pwR
         In2A==
X-Forwarded-Encrypted: i=1; AJvYcCUTtI6uGtJUpYWGBIjVdcq3vzzqiWdH46bgTviN4jvR7ITZgeCMtEZc/j1GTjY+7IxRMX+SkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3buIqFMoU8zm4m1OcjWspWcRArpXEv4BWJIzYLW0kjo+LeRWg
	IhmJB2OMRYkPVYNRntfyWAsGqzPwXQRfhpHwW/EIZP1ZC+TxOBkt3M9ebPN/Rg==
X-Gm-Gg: ASbGncvEbms84Npej8yRPuD2gHRpu421hEgaY7tEANmXoK0FriZyJKl/aXnpXDziM51
	fIZjWVgwfmWkm8/6rOL7pFvxO1MzRL4Hnzhyt7r63oKdLvvyUACDDutnK/zyM96PGFNkZxRjBVd
	fb9kv7R71VMigAUj9i9NuqkIV9mmP/eWi1+if3LFn49JauO6Iith6zVL9s8MQ4YF+ecSdXYdhCh
	DPRG3OV6gg16lUKtcWRlTHIE4gm8Fe/s5LL8mVBUFil0VqPLhN6ut6ymrZQyaTBBLk2yTaaMPDk
	xX6cg4GfXQ/zfFmOGHyACOf07XCgQI0dyIvN2Sg1VjG7ko6CYQ4/WAFeWGnnRbTDIoqH0DBpBOA
	sH4IxBw==
X-Google-Smtp-Source: AGHT+IHJNQTbOTf5T97irPUNv+QmXLRPjJqv5JLklJLGHSWfRRkbgYAKpGomh75s0qhLStfcG3G05g==
X-Received: by 2002:a17:903:3bce:b0:223:3394:3a2e with SMTP id d9443c01a7336-22db2189d23mr394125ad.18.1745429480637;
        Wed, 23 Apr 2025 10:31:20 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4292sm107648765ad.150.2025.04.23.10.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:31:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:31:16 -0700
From: William McVicker <willmcvicker@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe
 path
Message-ID: <aAkj5P1I-e9lylIU@google.com>
References: <cover.1740753261.git.robin.murphy@arm.com>
 <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <aAa2Zx86yUfayPSG@google.com>
 <20250422190036.GA1213339@ziepe.ca>
 <aAgQUMbsf0ADRRNc@google.com>
 <20250422234153.GD1213339@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422234153.GD1213339@ziepe.ca>

On 04/22/2025, Jason Gunthorpe wrote:
> On Tue, Apr 22, 2025 at 02:55:28PM -0700, William McVicker wrote:
> 
> > On this note, I was looking through `of_dma_configure_id()` and am also
> > wondering if we may hit other race conditions if the device is still being
> > probed and the dma properties (like the coherent dma mask) haven't been fully
> > populated? Just checking if the driver is bound, doesn't seem like enough to
> > start configuring the DMA when async probing can happen.
> 
> I think the reasoning at work here is that the plugin path for a
> struct device should synchronously setup the iommu.
> 
> There is enough locking there that the iommu code won't allow the
> device plugin to continue until the iommu is fully setup under the
> global lock.
> 
> The trick of using dev->driver is only a way to tell if this function
> is being called from the driver plugin path just before starting the
> driver, or from the iommu code just before configuring the iommu.
> 
> Given that explanation can you see issues with of_dma_configure_id() ?
> 
> Jason

I think the only concern is when a driver calls dma_set_mask_and_coherent() in
it's probe function. If we can handle that case in an asynchrounous manner,
then I think we are good.

Thanks,
Will
