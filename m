Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A42ED872
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116924; cv=none; b=WZmBgVnRw5o7LRDlxR3EY/MZxTMc5s2mQeEMz54YNFNh1+YxxYLtgX26mN71bhkaL4Mt7WCbhKuHNSyHG+i5X3GsXqvnCBfZHfNsxExYpqDQjB0UdTFW+6zVzlgNCQE+44omM9eSvBULwbM/QmTtmOoEwAoH5VLsDwHD+tJkMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116924; c=relaxed/simple;
	bh=nvP7U/Dl/xIbO6Hrcjf9FGeD1/9FM39srDJUAU6VEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctwe98k2wQLdmTD4wd9330O4LrXml3oDgd1QVquyPBTMsOiz0/Pi8+AALqjqtk0wYFW+it4e7D9zIcP81tu+wH83I3kN9tLhrJFA7AyhKOmjxDPV87r+YFweP+ktDACAQBaEW04PEJYRt0CDSR346GVAZvVlL8Lxk3MHDybTnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2iKjrnM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2iKjrnM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1495ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779116922; x=1779721722; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPcZ0QcVqHJUaR115s6MSWN7sWOXwruE9IKTdy4RibY=;
        b=p2iKjrnMtrgpkRDgfJM28DNdK9TI1JCOwqw5Rw+qrg4ITf26I99D4wyO1Wddx6NZWW
         CqaHvZp+zmcsOU28UWWMS5w4CMMCmnX39DQK4AMxzaThxfX2f0mYqrIUHlvMwufRoxKY
         ggPitl79+J0uu0qW0C2CxYNHGJYm/ayHLGOVOrsS3TrYpT50+Bk3byN4T7dX6Pj0Ghl1
         rmPZqXdhCdfexMH/GNuJTN5OFdUauhrQVc46gtc9VC3IpLFcVYyTm7WEaRrexHEL1eZt
         atBlqOgmVKxXY7YxODWqA6Z3iVoq7t5F6fXSw7vlFV8gqaf5KL11yD+LpKMdyOF1gQb2
         5xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116922; x=1779721722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPcZ0QcVqHJUaR115s6MSWN7sWOXwruE9IKTdy4RibY=;
        b=L4gTXg4zBNVKALC2Y10eLbsbcUY09OJbuVbrTYIBQ5UKMpE858nTDMq/Y4wfPYhRZr
         RGH8vQ7QFTlKUriSg1fBU+msHaq0/ADeNZLrAFn1/GGeLlxuxD7OYsg95W5fC95iFjkH
         8XYxeS3+jtP36IQo6cyriWt/WWhuBSBHeFG1WfaKgXYLLR81WRG8XqaeOEFfAUlMA6Un
         7zJweZC3kTp3AoBbngqcOABALWiRFRCWdfeX+/wx2uOLwbOnoj4SxoE/qmB+iyYpz0y7
         W1vzLI7bMeAwYhHwFa55bJuddDnueSd+v7w1b/7RywHh+ut5e7PbA1trQ9ZqFDuT1++q
         BD4w==
X-Forwarded-Encrypted: i=1; AFNElJ+8xTkHb6ElBwE9PYR9c/cjo1UOy4dqHmyFObm6KlbkXLGY40eBpT1FKy6DQvBPHPRvJ63fyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSyqCT+av9K4HKpvj8dBSWVAutOlHzkkymkMGCo1te5KeWU4eD
	+QxSYMC2JvAs6cdD5m1bpbLDoYQ6ROCgqn4sqlwExhTkTsA8xeQD2N+JoP8xpBqaIA==
X-Gm-Gg: Acq92OHU76ayoRAVLD/IHkuqVbDFP5mbcQvy7hvJCAI1FVmqC2O5Yeu1fyuHnmWJwVE
	kUaPKOQxAYkEzbvoP6eBXKiU1+oNqPPA/dVHtq5sDexHLWGPsYLzTiZLjn9uEA1hYzZQ8IN2v7c
	mHv9hH9Z8TiKrH0nuikjjOVnaDkiDTtpPS0AjJwVlbALo09qyrUQC9+k2kpypNQ2brUoF6eLDpT
	yuUREigQgm0IL6KRd6rv4u1PT10mrafHqzVsVjhTVsmJalupTCmFahMmAdmv/Yt1jiiE/yTz1pm
	NlJmHnoSwl6t4KJFf49uTV9YjOnPRo4hgwov6LfAkiYyOGSDJ66+AZJm/rlEJo9/qkVsxDT24DK
	QpjtGb+rsihxEr9t1o5Bi+HTeCAJqJJepwF+73zeW/YH05hX9NNR5p/CIiOwSFn2Mpbota1rlF+
	kQW4fpgXYtuZwpUN/TzqWxsu3WFxg2cgdPxUL/dvTA0sddVbt2zE41c+Jvrc1Q/D04GSkn
X-Received: by 2002:a17:902:d58b:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bdb36d252amr2864685ad.25.1779116921506;
        Mon, 18 May 2026 08:08:41 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c264241sm150322355ad.36.2026.05.18.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:08:40 -0700 (PDT)
Date: Mon, 18 May 2026 15:08:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agsrcKxL53PxFeu2@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agr9ggdY3GYltteV@google.com>
 <2vxz8q9gajwm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz8q9gajwm.fsf@kernel.org>

On Mon, May 18, 2026 at 04:10:01PM +0200, Pratyush Yadav wrote:
> On Mon, May 18 2026, Pranjal Shrivastava wrote:
> 
> > On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
> >
> > [...]
> >
> >> > +
> >> > +/**
> >> > + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> >> > + * @ref_count: Reference count for the object
> >> > + * @deleted: Flag indicating if the object is deleted
> >> > + * @incoming: Flag indicating if the object was preserved in previous kernel
> >> > + */
> >> > +struct iommu_hdr_ser {
> >> > +	u32 ref_count;
> >> > +	u32 deleted:1;
> >> > +	u32 incoming:1;
> >> 
> >> Are C bitfields safe to use in Live Update ABI?
> >> 
> >
> > AFAIU, they aren't. The C standard does not dictate how bitfields are
> > packed into their underlying types (e.g., whether they are packed MSB to
> > LSB or vice-versa), making them highly dependent on the compiler and arch
> > endianness.
> 
> I had the same question and Jason told me otherwise:
> https://lore.kernel.org/linux-mm/20250909155044.GN789684@nvidia.com/
> 
> I took him at his word and didn't really look much deeper. I use them
> for memfd preservation as well. See struct memfd_luo_folio_ser in
> include/linux/kho/abi/memfd.h.

Ah I see.. I guess I agree if x86 has it.. Arm should too.. I'll try to
check this.

Thanks
Praan
