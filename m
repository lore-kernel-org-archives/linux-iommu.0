Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FB22E3F9
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020779; cv=none; b=EOAB1fiP8qP1sRR7S4Ea4xTpBbWVqVME9EF2Uwk2Dlyi9TjVMhMrHDMRA1qjPEu59l29v4456bpuQi1zqxq/MK39mcBms7VHJvcBE7gLB7bCJ80lqDzVlgd+qjmXOKwqkvrzSTtRLs3Up+UcOY+bAf/P3mfGAfoU5ol1y+33V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020779; c=relaxed/simple;
	bh=NuqR7JI+G2rJv2MIgkxnyc3Wn5VBjRDy4vT8efoQxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnaNWtnA1F9sIE65xmQGDt0r9osVKcoqFaTacNR/yiKSRCLxZd2bBT61jW5RXvLBuAfbxQpR3EQvrToay2qR2inisG2/LLDoXOPuJ3v14tyfXgBctJ1xEaeWs3V6IiXQ6g5eY0jyo48hq4CodJ5bx9lDMfLZcrABFHKPInfi42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a8pnNYh4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a8pnNYh4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3b63dfee1so156241385a.0
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741020776; x=1741625576; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vVCncQiFroIxYBskOfYoTQ0oTclWTNPxKFNAE95aCHc=;
        b=a8pnNYh4P+FKKaIt+5CR2YCoDoPSlU2/E+YVml8S95aOCZVZ9f0uDPcLSCIBki8w3V
         345GuqNk2pthiofg6JxEYiARGr5J6zAVppbrJ7XGe0BHu/AmBslx1vW1AkPS9i4lAsRt
         fSHGu8OsmaOd/O70HJFwrllG7b/QoJaR6n9HxiwpqdgWpZd53MEeFAZI4n7iMb90jkFq
         INKACVRRc/FZSVbJmtY14a/l+qPiUa0GXDHdCTZ4BYVdQmUJwM0DpeSxVSve8adLGGnG
         NLYKOChVIs9flLiow/xQRRE2Vo5dQ31KTA5x1/u0Xb+WyNGO9eHOceBaSehQNMJp3NKF
         Iimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020776; x=1741625576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVCncQiFroIxYBskOfYoTQ0oTclWTNPxKFNAE95aCHc=;
        b=g9Lnd1Ut8g3BPCgJpDCSM2aNSbIKAsnXqITjyoDt27IiQj9LBz9UgExLqGe+RrtGLs
         ViftKp1a7cUyCKuvgj6gmpBBBZ1rwt/ql3ZkP4VDMNGu9Xdji4lvd9LoTVQG/mjg8SBt
         xOVDOqO805sB3tlpDhSVavIrVcfVAAHwL9FpCXgf6ORWTREdf3x39AOeZsgTiMuoCw+0
         wjvZhVnMfWvnpXEy0YZh1b5VbbGwLaopVFYNf88vnn4TkfypWIw64ASk/mMHjmLLyvcF
         m/tmgGy8QYek/MeA3ZeaYXJCBdHvS/EUFmg9fJL7EI/eqtIuA+sqIKDhIxR4RwU3ev/W
         d2lg==
X-Forwarded-Encrypted: i=1; AJvYcCXcgN4f43ds1XL74SVIhmB2A1lzCIlxCAl3N/fn7x1etywPxCcg2vibh/fFjgcs3PaTa+XlIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxA9S82ozsBcE2Z9UFPf3Se6RroXtzRAxsjg0rOC2r5pTKR7ge6
	VhuNhCE++Snw9+fUv76obhMU0HrLjg1Co9P+g/+ApXXquEZZGaE5Zy0Vt+HRng8=
X-Gm-Gg: ASbGncsk4dGivkgssfstWlPBYrYS9gxeuKvbOjs7plZE2o8/czjmKjF1qfJLnm1tMPs
	dcpVdPyrAadcb4rGpfkeIPrDP8lClB+KzPSaGgs4FdhoC5mZwarfVQv3fzLiQ/W2HqiqZf5MVHY
	G18BGnA6jTDuqmTdXJiMh/82lJ34XftPZ/0G0nwgERT2iDUP8v9cYyUVAD80wLEcUo8bmJ/sygE
	alV2wKJOb5Lyv+v4JsREQ5H0PwDkh/D4WuCAzX5tPzCnoMkTi1+/UtPzob1buwM1QdylvgGD9BP
	jSZlDmKoa++nDtDvWRPXeQY/P4tCsFRlby7UK8CTHOiWfaKoLwKfDbRS3Nmt3h8UEjDjtoV9l1G
	HiDITLRn5wADQg1qIxQ==
X-Google-Smtp-Source: AGHT+IFIf6jYsBfdvTc0EikS5Xpb0DbNcOeZPaKcF5x+vop09uaQoyucRacuzLKsWcUPdgqNiYKzIQ==
X-Received: by 2002:a05:620a:190f:b0:7c0:b690:8468 with SMTP id af79cd13be357-7c39c4ca479mr1861404285a.33.1741020776537;
        Mon, 03 Mar 2025 08:52:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b8cd9d36sm165720585a.104.2025.03.03.08.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:52:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tp92F-00000000ok6-047X;
	Mon, 03 Mar 2025 12:52:55 -0400
Date: Mon, 3 Mar 2025 12:52:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250303165255.GS5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303103102.GC13345@e133081.arm.com>

On Mon, Mar 03, 2025 at 10:31:02AM +0000, Mikołaj Lenczewski wrote:

> > > On such a system it seems like your series would break previously
> > > working SVA support because this patch will end up disabling it?
> 
> Perhaps my understanding is flawed here, but I was under the impression
> that with SVA both the core and smmu MUST support BBML2 to use it safely
> for core translations? 

Yes

But today's kernel does not use BBML2 in the CPU or the SMMU so it is
compatible with everything.

So it is an upgrade issue, going from today's kernel without any BBML2
support to tomorrow's kernel that does then you loose SVA on
previously working HW.

> Hopefully, as you say, the MIDR list restricts the breakage to a limited
> (ideally, zero-size) set of implementations which advertise BBML2
> without conflict aborts, but which do not support BBML2 on the smmu.
> 
> However, if my understanding of the BBML2 feature and how it interacts
> with SVA is flawed, this will obviously be something for me to fix.

Lets hope, I was not able to discover any NVIDIA platforms that have
an issue with this series as is.

But every addition to the MIDR list will require some consideration :\

> On independently enabling BBML2 on the smmu but not the CPU, this should
> be possible.

What about the reverse? Could we disable BBML2 on the CPU side on a
per-mm basis? Ie when an old SMMU attaches with disable the
incompatible feature? Not something for this series, but if we get
into trouble down the road

Jason
