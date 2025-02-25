Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764C1A238F
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502080; cv=none; b=kBJEwJwIKaiBNlY0FtzE7r2GOvdKaVF15fjpNEqhcd8u11IPY66ne60uepl4DJoQ1trkLLVSLlyzo4wr+sn9ZZKCQ+hQahBPDBKnpevNj4ofL9cGTqOH7d/blkF66DLpn8pzn5Btv6fDAVd5DgPyJ00Xrb1KhsxknmUVUYkvb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502080; c=relaxed/simple;
	bh=6iPgSZh+iO33nHQzseddwrKUrNhaFUNY8ua+PPksf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhoHKXlN4Gr0WhPzvGEGMgSXbbYz2Q3MZJ234h8Ajji8KxpYMkQDm4Egtflzx+ns7x1QYMht3X6epB9elGTYA7yYcsgmdcGTa7U3LrYrc3gtoxgGsl5eH3a/RTKwDWAQ5UMs4Au7eGgxLkm3OJujsNnkSWFCF64JwXJKXzs01QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mw8O0HKE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mw8O0HKE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220e0575f5bso216655ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740502078; x=1741106878; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TXPG1g3tHBq7F0JV2QmBmMxnoyZNN73F2qMEQ/D5jc=;
        b=mw8O0HKEMX6YHbpThlLM4B6yNPpkW0gkHJTEj8Nl1TtaNvOqk2ZHn5dP5L/zk4TCa9
         /AAQwlVTJTFBqjP1EQsDQSZwlpdc2iBZ4KIundajGYQ9KnebMYoJL/AemFvEVcSwyGa6
         qymr7yriJ+hUQNmxpfD0BqhFKdu85w0muEsmP+geUGdCvFp+oQwjw0iM0HKR1v8ipYTP
         8YygV/TbTUEgYGLygy+P8+RzGp9Wb7Keu9Dk6lRB0s7rO/QGKbh+JUQBJg3F6jzbz1nV
         J1yhN6QTVFMDLcE43nwkDiOjh7yp/CcLaLSvR+O81DBThPLU2NK2MGzUFm12EM4DOLJB
         6Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502078; x=1741106878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TXPG1g3tHBq7F0JV2QmBmMxnoyZNN73F2qMEQ/D5jc=;
        b=mk0D/44dCFI1xneAPCKIsyRAfohMH6QIl7KTbZ46QoDZMfVkXzwGaV4AgZYNYsGzty
         cYWOJEZCwZ6fee8K4KwM3lCUGrVp8xE3zD7pqk3sjs2n770/V9MNo9n4CHjEG+2jbBY8
         maeYKCvQS9lFFITIW5UgxWz+wO26hfFnnIx0btpYD+9Q/7QFxJ3WvioB5X+cAfffKG+g
         eD3X2+2igTznR+e4PPcJ4WPrK2Ccsdk43PQrNMmMZSX/vBYBUHXcTru5ARvxlqBc5zAx
         qSv51ahzICFTiBXKOpuEpNEAwKv7IEhPo8sVCmhOz3BBtyjo0Q6vjAR9zQf88TiHJnvG
         o0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0lvDZb5pFgw0Z0UpYf+oJ6htPnIDVwm7X86fCLsRfbd26/eNEdQ0ADqwK0wovsvyal4xwtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwofF7tAqz4dqwFBnnIfKSlNIWNztmE1+YMGvOWJqgI/n/+zy22
	Ibt6GbE5z7sS0LN9ecXG5whGJNguj60NTN085KxM6xAt9n3npIptF7pQqBpkPA==
X-Gm-Gg: ASbGncsx7LC7BK4nuL60GVUHF7oHFDU63Jgn4B1kJU9MZgUf1DPUKXqvlD35tzxWwI/
	f4wJ39u+rsMWrGmkbfq8KgW4A9PO9cVCklSTUgz/wD883QsvfQ5KSL04/3EflzVXUI+77QYVC0G
	W9D+sYA1U2dAX3+DrlURLuFgYFVheqO+T1dQk1acBrHb0GaDDRxJf8vfU09M+g6rqhWy+gFBQnJ
	Chj/d5dnZGFAuD5mD/vPyulz2qVI/vxDLec9AVJed2WTGDKZhCoqsV7Yvk1lDJ1xN57x7Fj6CgT
	PrKzBSS1RPjh/gkA3zyPG0aU6XvlVfwE6HFwUpqERfOxrVQZAJBXFgoe/K5YTSU=
X-Google-Smtp-Source: AGHT+IFvXw+OvC4N/IKxwnR5Ayk0dG/Aagp8HSvp5fGkA6z7Brsy0CGy7v+QNECgYTSPzGrZqtSVWw==
X-Received: by 2002:a17:902:ce91:b0:21f:465d:c588 with SMTP id d9443c01a7336-22307a60c47mr3818095ad.14.1740502078043;
        Tue, 25 Feb 2025 08:47:58 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095f02sm16558235ad.152.2025.02.25.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:57 -0800 (PST)
Date: Tue, 25 Feb 2025 16:47:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z730M3XptvDRObBp@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <b1930038cf828dc13c080e2b46b3003a8c98ef24.1740238876.git.nicolinc@nvidia.com>
 <Z7zmErar4YvQSSxw@google.com>
 <Z7zrHn3tPBD5chv1@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zrHn3tPBD5chv1@Asurada-Nvidia>

On Mon, Feb 24, 2025 at 01:56:46PM -0800, Nicolin Chen wrote:
> On Mon, Feb 24, 2025 at 09:35:14PM +0000, Pranjal Shrivastava wrote:
> > On Sat, Feb 22, 2025 at 07:54:10AM -0800, Nicolin Chen wrote:
> > > +int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
> > > +{
> > > +	struct iommu_vevent_arm_smmuv3 vevt;
> > > +	int i;
> > > +
> > > +	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
> > > +
> > > +	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
> > > +				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
> > > +	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
> > > +		vevt.evt[i] = cpu_to_le64(evt[i]);
> > 
> > Just thinking out loud here:
> > I understand the goal here is to "emulate" an IOMMU. But I'm just
> > wondering if we could report struct events instead of the raw event?
> > 
> > For example, can't we have something like arm_smmu_event here with the
> > sid changed to vsid? 
> > 
> > Are we taking the raw event since we want to keep the `u64 event_data[]`
> > field within `struct iommufd_vevent` generic to all architectures?
> 
> The ABIs for vSMMU are defined in the HW languange, e.g. cmd, ste.
> Thus, here evt in raw too.
> 

Ack. Makes sense.

> > > -	ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > +	if (event->stall) {
> > > +		ret = iommu_report_device_fault(master->dev, &fault_evt);
> > > +	} else {
> > > +		if (master->vmaster && !event->s2)
> > > +			ret = arm_vmaster_report_event(master->vmaster, evt);
> > > +		else
> > > +			ret = -EFAULT; /* Unhandled events should be pinned */
> > > +	}
> > 
> > Nit:
> > I don't see the `arm_smmu_handle_event` being called elsewhere, is there
> > a reason to return -EFAULT instead of -EOPNOTSUPP here?
> > 
> > I think the current behavior here is to return -EOPNOTSUPP if (!event->stall).
> > Whereas, what we're doing here is:
> > 	if (event->stall) {
> > 	...
> > 	/* do legacy stuff */
> > 	...
> > 	}
> > 
> > 	else {
> > 		if (master->vmaster && !event->s2)
> > 			arm_vmaster_report_event(vmaster, evt);
> > 		else
> > 			ret = -EFAULT
> > 	}
> > 
> > 	mutex_unlock(&smmu->streams_mutex);
> > 	return ret;
> > 
> > Thus, we end up returning -EFAULT instead of -EOPNOTSUPP in case
> > event->stall == false. I agree that we aren't really checking the return
> > value in the evtq_thread handler, but I'm wondering if we should ensure
> > that we end up retaining the same behaviour as we have right now?
> 
> Oh, it looks like -EOPNOTSUPP should be returned here. Will fix.
> 

With the fix to return `-EOPNOTSUPP`:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
