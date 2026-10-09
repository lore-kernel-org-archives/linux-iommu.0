Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881473546D3
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563560; cv=none; b=cxeRYhUP3r1yt1FW57MzONHuCR8ZfLr6K5gveBrKCpSa9y94zCl+74VTYdb80bKib3MlNoJkzehTZT5X5gYR0+0H897GksjCOjEXZS2uApVgzpnSBLs9/sfEtctmY4gnk8oZN1j441RJ82GgAa++nk7aMQul4jw196Q+5V42nzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563560; c=relaxed/simple;
	bh=07yf6xBRrUXFeq5vbgPfsiIGYgZGyZxl3GUx7RyhdKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG7lgNAYQ/lMz7sBh66PuWNJIKiQARsb184hCx1Jn7iH08+t0s5eIBIpQH5DBFOCGKLHpjnAsZfFF34oyrs6xZlGrVBjEKE0zLzV/xsXnwn416V0/SBTVKn1w/vangL+YcH6JGhAu9Qebx/Ma36p/DDWoZ3QCk8K9w1yuDlcgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kRRrhG2+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kRRrhG2+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e6eb77f0bso542446185a.3
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791563556; x=1792168356; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e/TRD6BwLaJ/NfMLCCm5dSOuj3VkkC7kRDobdLq+Uh4=;
        b=kRRrhG2+TmWcY9doa3f6+oObPdfa3V4kK/Pq5hMwBh81cqd0vAaU1KWRw2tQ8RFTAv
         lGWTyD6Cd9frIIQCXsx51T1NwInqYuaNcdn4FvjIiLbStsyUX0XY03zHtINyzcUf6+eU
         K7gE1W+raivqxfFa6ioz3YDOaGRC98FhWSC3Xpt3B8X6OdANOJ+Kqv58pRZ+E13X56fG
         jxJu34BbnzA/ObrA+bEjTsM0M9ZsVH34VYoT6QEOLvnaUXPStlHQhVdUGfMJHFv55elG
         8VrSxS9mEJSvefOs9klvGC8st5xx8v7Nw+MFkCvU1WT28YBpBJqWHS7QcX6/VnVdGXYv
         prWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563556; x=1792168356;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/TRD6BwLaJ/NfMLCCm5dSOuj3VkkC7kRDobdLq+Uh4=;
        b=ksD3tMTiLMgpSUg3k4ugER5ttcdrs8pBbLr4aTfFuf7MKkZsG8oMac2hT7+BnBWgX7
         A3S7y5lpdJVIRQZ5scSO67Dvb+K+gbbhmwmMw07ScvnyhNto2rbcTDFdvoOuwki2+w8s
         QuhpZm8Eck9f90wLTZ7wUErX1lqVI3lI2jpLKBpQrlyIwD0ZxLaIsto7bgcYdt8dtY4b
         xIdCZBAToJT7wIyFFdaVWKK7KOgeY1PNapauhEgOO/CJmnaaxy7MtCybDLsj7QsAndHS
         kOi00+7eJQelDL0x2YEXmUDnG/1KZ6KcfH9afHKNnwpO7lDSeyudI7HAFUjpVlRQLvQN
         ZOwQ==
X-Forwarded-Encrypted: i=1; AKwUvByz3MamRmTfYPsoZvLSemk+iJtKrN+/qB0h3m101nb83xV3XtqNA/r3Ty0E+0vZgciOhyWbIw==@lists.linux.dev
X-Gm-Message-State: AFuF++mBp4H2qPDDQd791LHICr22L7QRaiwtZUY+8pV9dkF34mfgTxyb
	EzTTz+sZg1mMDdveJNOq6rMG63dQkaeaCjRyXvn8dSzTrZKpmuDArWBDOZvDyJTrT5M=
X-Gm-Gg: AYBFou2aIpb7XE13AF4SeCnxdEDiTJZczuN1Hq9O8SmnEyso4nztgVpYLw+ILvnEm5c
	svjo/TORCIBJ/Qt9dE33AgaCTTlpUpeLQotsIURNZtfGRi14cYq9pvbOIKSjB24HvEvrsBb3PJf
	a/pwIXTiLQq48Sl3cSUIG1HG7pgLIb3vPypndJoVM5b8cYWNKsNMPDrBPYg1svlt1cUfvtOhGvi
	HEhx3dG+ebTeLoOWTnQNnsmafXuxvV/DDlsXag6Hs5dfSvzTAbt+C9gYAf7foevL1PK75Y71MRg
	NDqJFmt8Y1gryQ27ggCdoMdbQoemBPpddXzGG3KrCHcoQ/0HOVzO7cXDNsn+UUhFR9crohyap1Z
	QvEvyuAkGXD8ATtQevH3PVKEYnI14Ue0eWRQj5ymMu3n8cC9C+oRQMlHNgSLr6v5H/FhtCEZW2J
	vNKqtF2Q+Qg6hKMo8Wm+8duRRX7C+rZoLdCo1GdM+pPQgqkbim2lVszFXDiVWZ/eRqs5ksVCDKY
	ca1px0bFSJI4TYpR+pGWY3UTqhserryTFTglz45jJfb1QzqM+RhDUnJ
X-Received: by 2002:a05:620a:4456:b0:93b:be6d:4f3e with SMTP id af79cd13be357-93ebd1b7386mr410267085a.25.1791563555872;
        Fri, 09 Oct 2026 09:32:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98906c3sm225037585a.26.2026.10.09.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:32:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xFDWK-00000000Kpb-0HpH;
	Fri, 09 Oct 2026 13:32:32 -0300
Date: Fri, 9 Oct 2026 13:32:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	Daniel Mentz <danielmentz@google.com>,
	Will Deacon <will@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Message-ID: <20261009163232.GB14213@ziepe.ca>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <20260924001502.GO1540250@ziepe.ca>
 <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>
 <20260924225340.GC16465@ziepe.ca>
 <7ab6eab6-ec6e-47dc-b387-eb380e2e365c@oss.qualcomm.com>
 <52ba8a64-2d3d-4c3f-ae8f-54ab4f0f164d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ba8a64-2d3d-4c3f-ae8f-54ab4f0f164d@arm.com>

On Fri, Oct 09, 2026 at 04:37:08PM +0100, Robin Murphy wrote:

> range size being unmapped, so even if the total gathered size exceeds a
> single command, we still wouldn't split it _within_ any single one of those
> ranges, only at a boundary between two unrelated ones.

The question revolves on when the iopgtable path flushes gathers.

If the gather only holds a single page size and always starts aligned
to that size then the RIL splitting algorithm won't cause an issue.

It isn't a question of allowing CONTs to be split, it is about when
consecutive unmaps can merge into a single gather. iommupt is very
general here so it can create gathers with mixed up page sizes and
trigger the problem.

For iopgtable we have several layers of logic splitting and flushing
things. I keep forgetting about this bit in iommu_iotlb_gather_add_page():

	/*
	 * If the new page is disjoint from the current range or is mapped at
	 * a different granularity, then sync the TLB so that the gather
	 * structure can be rewritten.
	 */
	if ((gather->pgsize && gather->pgsize != size) ||

I didn't try to do a full analysis that it really is enough for this
series, but if size here is the PTE size including the CONT effect
then it seems like it could be OK. The gather has to be aligned and
has to have a single CONT size within it.

My original reply was mostly to be taken as 'RIL alone isn't enough',
meaning write an explanation someplace why it is safe under the
current system. The commit messages for the SVA and my later fixup for
iommupt explain the general concept and problem..

Regards,
Jason
