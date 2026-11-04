Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812100;
	b=g/68Yo2DdMYMcwNw9a83MGYwmF5G0qcKT0A+48ijfTVWVMPVzChfXTEZY+p2os+bqPjp
	 42q0m9bTplH7sIRwwq1yQ9mCRlNjOJctSxqBRr3ao2vs9Fb2EfraOSqL3ql2qzmodWiVb
	 pAS2CD+BcwsJoHV5NFDyWaUOeZGqLUKi9FQ2C5adssin8uIx71nd2GskSbr5rcmYV3cvq
	 tSVw68i3W2mVXVWvske3VQ74OB4eMQFFEmkDeZV2t1gdd8erMoGRqtYtESBKktHNgGhUT
	 jjcM4TleDGnMa2QuDXRK5BPBDMwHuxRcFYy28xYQN3lOFz1xgCNfZW2BXYblsQcbv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
	b=TG7TCzaKxA0rC/m8dGA+BbTThryStI+Z/FzPMpm6sJp8yxy+Sf/rDFe/fQqOLR/HP6tW
	 31AeqeBP/xGWzIuWbZ4apeOE9y4hJPYBj2aJqyLfV3oexaP8pp4yz6j+xvW9dMOgl/SSZ
	 BObjlBJlDdfRffN6LcWNspR1OkUUzpEkpaIrtToEF4o54YCv7LM+HlVe50d0NigW+YRAm
	 BqGtKqCesQq/bmJjUlzrMTg6wTnKNccBno+YWINQiE1FKdVaPrBfplAOpqPiB2i/tf4Ze
	 cxP5UBxCJ49tPt2oWNE/WKzIeVc0yFWa5V97nfoFzg43EH8O3/AlH/egjPafkvSJUZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pO9YXVAU;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0923606A334
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 17:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0923606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=pO9YXVAU
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c6ce60697so12816096d6.3
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 09:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793812097; x=1794416897; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=pO9YXVAUaCpN7QTLV1L5+auyGYDYUu6p/uf0L6jGfpPIjy/hZWRiIfHVmtIxVqajnP
         1BWng3WieSadZ1quzjodNKgo/aq6FRbni5etMQU0wHC5aYid9jtQFgNTH/ZBKPwNXACB
         XwtEn2iztufujBjzZUEuRYNw9G+YizPQ2P+7hoVfXbUL77ZiLkicJkdTOJXvYUfgUAp/
         E8YqcShle947H4/kJiflr6EDQqn8XaimfdkvhEWMD2Y//dKE3JFcGqBIwktWCi3hGoAH
         8p9f5Ubkc59W8a3zGmdSzy9udNV634uY3fKAKCkNA817aeKdWDXLFgcnX1nvVe33frGV
         oB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812097; x=1794416897;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cd/4uVL9g1Nhrnk0AsW+3azM4Op/nEC3bPpOibZ+Gdk=;
        b=ouSmEjyrwu0FC/0ih4Ad0juKy2Tpy9Sp4lEvzZoXrHKrM6OdfJQ4czC+l/upXVxVbE
         kPx8uN3oab4bxRBd6N3YkkBIhJp3CzY/se7PzePfWsT4LnGOFG4/YBcFYjq4EKJPiJTr
         fkUyBmk0+cMbNh8kEAjxCTlbvkQxIKVG1aeiwhm0MpMiZK2IiqRirmmSNcnusKu/yY7l
         mKWc/Was7SbjXk4M/9d7JvXQ3KpFSjNAZzWAZVMYKX1ZKyr1b0zytjygzPQc3fhwHAyg
         2ZgUqmepm32KRjwXXLq0yZ4UHE3JOZg5POT9bO/swA8yuzP6wBijbyzciV69/eY+IGN3
         05mw==
X-Forwarded-Encrypted: i=1; AKwUvBxl3j0LEzf0nZBOiHORALC+aaKmSyGRsFGRTBMInrLobdDPFrzo+g2SankrwD49896YHyhJbg==@lists.linux.dev
X-Gm-Message-State: APuU4Z98ljkh0sl0ed2aoRv2Go0sduYq1HwjKvtaIaN9r0FVV34Bpm6s
	Yzy6ol0FudwnVAUU5qWMYuTfa2gUAhCe/jdFK0zIhmtpyIPAGyX37jCD9xt1vzAUqqg=
X-Gm-Gg: AYBFou1cZRF4w7IYbAbpmd2duqH9wf/sPVNe7ZdCx8Voh4Mb4XWFPIikFuirGX8h47U
	zP7qlOXxzZQ7enfF7E9bzhPz+7bwFp41H2ycmb2yh10BPhNclQ/Hmd58JZuOnkpdY950lFQoECA
	Uz2wFfYTmPA+WKUdnc/em7TYfMr++5y+RiAWdaqNWWiOVWLZW9y/CBC57vAYj4mqDUBZ7xAb3Cf
	ey9U7ivagdCgMSt2H7W7o27Ja5+5RB790obs+MkXO0xNxRzOPR44AaiV5WAgWs/A6ugwgvad+RJ
	1HvJSexb6wKjieigLr3CLtBa78bHPBTUvkHi0ayxQdGzrQDDhzkd24qKGgh4uMORR3bDt3kaWTc
	mkf/fG5lndWSTxL2fpuDNHq6GzG0cL5Ah3GxJAZB6FN73J1kRplzHYGg85yI5KYGT+PCjs4iE2W
	WQNGxjKL5f7o4mZeNyjmetOR25AJK9avIgbsRuQTjJ8pJGedVNLHm4mJDoi3S5hX6g69bl0eI7n
	4JBzYQtTde+CoEwqedo+s3LnLdO4lQGz/RyFDY7zBVP261IoNm627BxTbExNcEcdIM1G8QhuBgY
	KIzDgzy3hXzvcxH4YBlE+JHjEln0KPDqgijeW0D30+BkaH4o+WvdthdKMPHhoXEmofDpLQd9B5/
	r+eJWkLrGBg==
X-Received: by 2002:a05:620a:4014:b0:944:dbd:831b with SMTP id af79cd13be357-944216dbfc3mr2925762185a.51.1793812097533;
        Wed, 04 Nov 2026 09:08:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d482eb96sm247450485a.23.2026.11.04.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:08:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOeTA-0000000GghE-1hbL;
	Wed, 04 Nov 2026 13:08:16 -0400
Date: Wed, 4 Nov 2026 13:08:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261104170816.GS3889730@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausIn5Txiy1uRjkY@google.com>

On Wed, Nov 04, 2026 at 10:27:43AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 26, 2026 at 04:10:03PM -0700, Jacob Pan wrote:
> > Hi Mostafa,
> > 
> > On Wed, 21 Oct 2026 10:57:20 +0000
> > Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > > On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> > > > Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move
> > > > or attach devices to another VM address space provisioned by an
> > > > external owner, such as a type 1 hypervisor.
> > > > 
> > > > This is not a paging domain and is not sysfs-selectable as a default
> > > > domain type. It requires external owner context, such as a vIOMMU.
> > > >   
> > > 
> > > Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host
> > > never inserts any mapping?
> > Right, the host does not own or install any mappings.
> > 
> > The external domain type is nevertheless useful for two reasons:
> > 
> > 1. It allows the pvIOMMU driver's domain ops to do the MSHV & Xen attach
> > and detach hypercalls 
> > 2. It allows an externally managed device to leverage the normal IOMMUFD
> > device-to-HWPT attachment interface: VFIO_DEVICE_ATTACH_IOMMUFD_PT
> > No new ioctls.
> > 
> > It also makes the lifetime and ownership clear for IOMMUFD and
> > hypervisor, the device can be returned back to host iommufd owned
> > domains once detached.
> > 
> > In pKVM case, my understanding is that you have a emulated root SMMU
> > which does not do hypercalls obviously. Then the external attach
> > is done via an "out of tree uAPI through KVM/VFIO bridge IOCTLs that
> > proxies those hypercalls."
> > 
> > Therefore, if we were to park the device in blocking domain while doing
> > external attach (as you suggested), this requires a new PV only uAPI
> > that must support pkvm, MSHV, and Xen. So it does not fit in the flow
> > supported by PV IOMMU root driver.
> 
> I am not sure I understand this, how can the domain type change the
> uAPI? can you please point to what breaks in the code if a blocking
> domain was used?

Yeah me too.. The plan for the CC side with TDX/RMM is to not have a
S2 domain in the viommu side at all. It should not be uapi brealing in
the sense that nothing using mshv viommu exists today.

In mshv case the iommu drivers are telling the hypervisor what to do,
so they have to effectively see a change in translation. But maybe
this can be managed internally to the driver by annotating the
blocking domain attachment?

Jason
