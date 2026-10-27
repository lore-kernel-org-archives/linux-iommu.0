Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139591;
	b=QSsbQgsgYIMLDWjXsNJeWeH+XKIO86d4jIJc7XsXcQXxvuk3N3LFURZD6oPHTrb51nty
	 iOwY9Mi6and36lWG9IwG4oKNJWasD6GJIQGjhdav61JqDHOzFVNy+ZLqDURWZB2F6dxI+
	 IgAoBvrAQz0UbrPHH3sw/DfcVKV7Ue/eJLgUjlbAJShkX7w17hnv8Mrqgz/q9F9yKgcHi
	 wKX2ReG2ZD9E3w1ocR+eRJcW9QO0ibZVv22/OYUlozq8bHe72i4w/42yoP69pYthUKeKk
	 q69utr5BoEezjVMuaV2pYHQm6eQA3xjQMLco38DfUJjlhZbgJDqck7n79ZFR8MWEMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IRLDp0EVirBnKgldSRz7ToSM81j0nsSsdeqUHhLddpw=;
	b=rcAp3SPHzViDVCtqjnyxB7L4dkqVu6uor/MnqeXfTb6zs7rCnqp7FbRlnqBUV+IM47zS
	 U90r0X/xjMh7CrkpJq1k8mo5qs8I7XIWFe8dSdImXbOrSrYKzvXBSxo6lHVNDez0Dmals
	 FaCNYe68E0Wqk5y/9fL7HiCDBoF9ZzdegUjumbMzhf4cEdx81NZIfSIHKR1jtSOtoxbjz
	 8WIO8ThCUkXk2qtC/gQ/m8qcX0pbkSo+u/9GUrrtKGU2LHfouPn6O3NHwoKn+X21xL5VO
	 IeFF631IyRxeiGnFGh23F93OJIYJrHRoGdQEZF/qeLjkR1Sapt26v67+8TOMseOOK2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoSOl7PI;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA6606A31D
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 22:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72EA6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MoSOl7PI
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so26215ad.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139590; x=1793744390; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRLDp0EVirBnKgldSRz7ToSM81j0nsSsdeqUHhLddpw=;
        b=MoSOl7PIkeGce068gAh7D8G+7RnRcf1PuJr9LdqRXqiM5yaz84Zo3Yw+KRrL2vptyy
         cHSV/CR9uW20xoAgm9uIHG8CbWDVqZV2D590aJ9kKY1jqqg2qQhX/OXySZ0obh4LmXkF
         6uzPaIl2mxI3Jlwm9VEtrmgll8gHm+5No5GwtTv6ZeCmrAv37EryrESfRlMQHwxGvUJx
         6jWBOKW5rIB9qWJQY0wNFXIbNqrRBYlujKV7lvBZlvpCZ+1jT7cuTh4ZgfWZ1ohh/2VH
         /mr1RrNXV5rQkz79T4kQldT+ALmrApbl72yXlYmslfyN8Mq9ztjsjWrXaDi89RkcjloH
         IZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139590; x=1793744390;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRLDp0EVirBnKgldSRz7ToSM81j0nsSsdeqUHhLddpw=;
        b=TUiay7XqnAa1XJmOTFm3bKzIO6v3EPIAjD7EXxyMLwVRHKAODCAw3LyrQP/TtX2shJ
         NZgpl011kng6+q6cCl3zv+Hvz/FS9/apoUM/SWO1x3LoF56QYaslxb9icyGlhS3RUMfU
         afQaV/MVOweRadizPajH4sXPF4JJu474Yjsz/9HqjIjZVOpDNxrKas0rTkXdOmj3FlK0
         XzueLaq4k6EgEo4I00cyhjfsneChRZBxVQGPkRPhJp61S4ketaCw/eaZlyXeI1NxCp52
         4uRIp22v7qhGiAyR/ME2o2QE7Hfnir8n9mqwrI1BpdLkllCEPHEVrNNwKwyCpUWHqZBD
         avWw==
X-Forwarded-Encrypted: i=1; AKwUvBwlKprfjaiSmrvjCCYddB5eAWdxlkt0DdGaPb4HOzcwR5wI8qp6+rxqMqLmeepeMHqfRkhSeQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLW9UAnkw8c+xHtpMbvf6kxcaADhpwkDfmFs54mzL6bAvq2NoaH
	kcAi+70WDhIL8L15vWcQZiHFipEoc7D8TsN90zztjA1FRWwiEpA1JFKE3ry3YzcUiA==
X-Gm-Gg: AYBFou3rH1v+RQ44H8r5y8LMUbNOREqE0dpWVFIpAkJjhW/cBehDQVZIIjNdC2a+1Nk
	6WkaPecKxs6j8RRhW+oelOluNNXUjGRCbt+urbvZnY9DBX+USs3q/MHAnI6QIBac4kQ+/PqvHjl
	NNjJpY2y0A8ZfKnmmpKWW63QjD99htM4SrRwJEcF8sVZLYrimCb8TkjO8lZprgI9rauU9U+Qr4+
	e6i7SnzckOymlXLI/zmUFLW4JMGlx0DYwBcdS1ZPt24AmSxFP8rYm4wm4XDdaN5rstrf54B3VQt
	9qt/9j7KOyhf2I8cm0OEudjiUN2fOF7WfRZZLPImznnhON34Fajq789vYIEHHCZsjKxX76MxZyV
	Jvgjxpq7uHafBpzoz/C+Wyl8eQw83scZ8HBtbu2urWlK2N7rzk68Hd5bKj7U73dYEDTMhJGdXU+
	4p9xMB4awjdbdGsN+IH/Qa6J9v72TCIw8gfld5TF+8X1tosdPiz6WPeW6upnh3W6N7edDKMtQ5K
	Y/0Mydjji87PkNKW6V9u8yMXmplW4ZQR+qEp1uYPhXeYewPms8nFdFXtitcEjYY7a0oLtTD0qDT
	pOVjtW7kiKaV8aPL/LjlayIxFepRaEBbYC2ETOKmNgVd7ZD6Gw==
X-Received: by 2002:a17:902:dac7:b0:2e9:8c2b:979f with SMTP id d9443c01a7336-2eb018f7c12mr1057445ad.8.1793139589374;
        Tue, 27 Oct 2026 15:19:49 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a48c2d3sm152945a91.5.2026.10.27.15.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:19:48 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:19:43 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless
 replace of S1 domains
Message-ID: <auEf3eH6QoiM-f80@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-4-skhawaja@google.com>
 <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>
 <20261023134900.GB3977851@ziepe.ca>
 <d4570e2d-5b92-4f05-a8b3-34d5d5b299bd@arm.com>
 <20261023142909.GG3977851@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261023142909.GG3977851@ziepe.ca>

On Fri, Oct 23, 2026 at 11:29:09AM -0300, Jason Gunthorpe wrote:
>On Fri, Oct 23, 2026 at 03:04:23PM +0100, Robin Murphy wrote:
>> On 23/10/2026 2:49 pm, Jason Gunthorpe wrote:
>> > On Fri, Oct 23, 2026 at 02:43:28PM +0100, Robin Murphy wrote:
>> > > > @@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>> > > >    		struct arm_smmu_cd target_cd;
>> > > >    		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>> > > > -		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
>> > > > -					&target_cd);
>> > > > +		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
>> > > > +					  &target_cd);
>> > >
>> > > No, we cannot blindly do this for arbitrary ->attach_dev calls - the
>> > > majority of S1->S1 transitions are going to be moving back and forth between
>> > > the default domain and user domains, where there is zero expectation, let
>> > > alone guarantee, that the translations would be equivalent and thus not
>> > > liable to lead to TLB conflict aborts or amalgamation hell.
>> >
>> > Heh, yeah this probably only works properly with BBML2 or something so
>> > the temporary ASID doesn't explode.
>>
>> This is fundamental VMSA behaviour - see R_FVQCK in the Arm ARM. BBML only
>> applies to the one specific case of identical VA->PA translations with
>> identical attributes _only_ differing in the leaf level at which they are
>> described.

Thinking about this more, in case of a conflict, what is the expected
behaviour? Does it result in a DMA fault for the affected IOVA, or is it
a catastrophic event for the SMMU itself, affecting other devices and
the whole system?
>
>Sigh, I thought ARM got past that 'tlb conflicts catch fire'.
>
>So, yeah we need a flag that says "I pinky swear these are identical
>translations". And it has to be a kernel only flag since we can't let
>userspace trigger this.

Agreed, this should only be requestable through a kernel-only flag.
 From the live update side, we would set it only when replacing the
restored (preserved) domain with the new one, where the translations are
identical by construction, including the page sizes used.
>
>Jason

Thanks,
Sami
