Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9036166A
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427383; cv=none; b=Y4dviAtXl/zMZ6AufyUoJJEHYnE3G+n9WK5np5mYQAUaEdA1gR0hd6UOQcR4fgxAeeyggLcpGQXU37H/TfCmYsjzrZsbZ6IOUV7e+PQl5nU3RX3UE8uMqpjzw0ZZzuOYW3X8So+z2ByAHsijjZrHVKKNl9l136npV7WyklimePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427383; c=relaxed/simple;
	bh=qG79F3bBT6jsj5MyZ+DmjyLvwJgCGA1ee7wOQ7HnB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+cJZTFhDNgNKl559aMKKZSbJXjdHOAeZN3DfdpLqL1dh4lFp3J250j9W2v02pwKdeLL2DgyZg9SLO1Tkgr5VQCROxW0NDYoIRbhNwp4BjbSTzLcXhYjjikFhFUg8Q5sv+kL3gSdCYRgwgZtU6yBZL+yYeKKfrgU7rB+drsjcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pP3Gbi7+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pP3Gbi7+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50905b779dfso28671981cf.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427381; x=1774032181; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33LRHogpGiDAoJ0hSgyq37DznMxJ4ZqKispiDKsO2iw=;
        b=pP3Gbi7+3LB1/HsiEqbs9EnqFlgC4A/hScjkhjCS0NeSC5c+CjKvw09LTbzQvvwXoG
         oyNv6EabiwwWfU47h0/7oGbga+SoM5zkWFcFo0UDlZDF2h/TDoIxzqCEHKfCIDXg1WdU
         Ui3dym7LPVdmHEftkerfUwdK6EYGV0JUi7uoetsXTOHLbkeIctiEQcbkqBYRoyC+/oQb
         tMfro6+JhBuQwIGZShQicgB5VuFmwdbbqOpqlJzYD8GeSYQxHijmW8FHdSD8jedvtMi6
         ZGutP+0NjCSo/hkORyfJE+bIJJltzqmAKWC53/ujnlSvpE+oE54ItYppuwbv97+4bVAt
         j4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427381; x=1774032181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33LRHogpGiDAoJ0hSgyq37DznMxJ4ZqKispiDKsO2iw=;
        b=r1pOnJJzLJf3Dfb7VgfYCDjuhHSAz75iFDSwvz41iy/sPMcK9aaw7tt8kkrUNu4ft6
         EutKk7Q4XZ/E/BXFnGwM66mv1+ZfBqmsWsfBphYkM2JMK89yFG36NLud5O1xiThCz3K+
         +uUCubZQtUVfELVd+4TxppoZ0KEYl48JQsgoUHHv89M/nzmp2TManZhMey/BIEBDa8d+
         GXDOi6SVpYvYGy+dLzTA1ABo2wVb6IeTZPu/7xNsTaE8HkX9QsJnI5+zUCEEbS8F7s+u
         PYYybvH9Pzrbneosh12rgamSFSdWPRbNkVTZVyW6qO452ge2Ml2leOcH/uxkImNGpnkC
         pICw==
X-Forwarded-Encrypted: i=1; AJvYcCXPo5AfL2Xi6XrfeIerdTETNqZv7E75gpeK8ot82mwka1qirUhlH2fb1u87CfAp0RjsU5QxqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFbuaMzAlLwkinQRjMWO2XXzoc2rI+KG5VLX4icg04Q/FE70ry
	UUBIl043K2khDmaOCC29upbWd4CmMnLo3QN95uJNAAA86Jm2WjnYOIF4ZcFj8Nxt/FI=
X-Gm-Gg: ATEYQzyAZ9j7wivGNrZL8YZhNXFHwbJE2a1gMsnfjN34X6OAE4aLwHbj81s1EPgp7yz
	Hi8aUmO+7XiHMo3Aflg6Ze4XgEEY7uyFQ8167J8CEN7GYr8aRJn80oQuJn9hNYM6uAoO1zzAyR5
	ApYhfctEczKwYLAC6fjIzlQz6rKdcLxhXSav+h9MkjsCl/i+qff/QYV31QqArtqh1BQ3IMcYcSE
	oaHh04SxeMfNrnguUtWhyk5kg8zQZ/RnwWkUfCcsYRmqylqi/iifoY7fgvE/Sj4TAokcAeeqs5a
	iY4DJ8FvRKd9nqeCqdmiPx6uyMP72WeJZTTzMuKhxc/rZrbry9Oo2s4zsQ2VABljUFb9uNPGnED
	sXGxzuq54gGci4FFw3n+igCw86m2gMTaxbRAazTqCA5yVDtj44VPMWONqYO7boIMxgWcPLKtlbI
	PkqmGkLp2bC+V+dcN6vod1lBHKbAOXJyUGYD5FYJ4wMToRTLRtQaLUzV1GisXUvy1KHEPLFkDTu
	oIWG2zh
X-Received: by 2002:a05:622a:1301:b0:509:2822:6701 with SMTP id d75a77b69052e-50957cc0c69mr54001261cf.28.1773427380808;
        Fri, 13 Mar 2026 11:43:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c071d4sm60555916d6.21.2026.03.13.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:43:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17TP-00000007M0D-311H;
	Fri, 13 Mar 2026 15:42:59 -0300
Date: Fri, 13 Mar 2026 15:42:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 2/3] iommufd/tsm: add vdevice TSM bind/unbind ioctl
Message-ID: <20260313184259.GM1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-3-aneesh.kumar@kernel.org>
 <20260311213555.00001064@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311213555.00001064@huawei.com>

On Wed, Mar 11, 2026 at 09:35:55PM +0000, Jonathan Cameron wrote:
> > +int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	int rc;
> > +	struct kvm *kvm;
> > +	struct iommufd_vdevice *vdev;
> > +	struct iommu_vdevice_tsm_op *cmd = ucmd->cmd;
> > +
> > +	if (cmd->flags)
> > +		return -EOPNOTSUPP;
> > +
> > +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> > +					       IOMMUFD_OBJ_VDEVICE),
> > +			    struct iommufd_vdevice, obj);
> 
> I'd be tempted to do something with a helper function to simplify flow.

It is already

static inline struct iommufd_vdevice *
iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
{
        return container_of(iommufd_get_object(ictx, id,
                                               IOMMUFD_OBJ_VDEVICE),
                            struct iommufd_vdevice, obj);
}

> Then the helper function can do direct returns on errors given the
> iommfd_object is managed in outer function.

Use cleanup.h ? It is not the iommufd style the break things up into
little functions for error unwind reasons
 
> > +	if (!vdev->viommu->kvm_filp) {
> > +		rc = -ENODEV;
> > +		goto out_put_vdev;
> > +	}
> > +
> > +	kvm = vdev->viommu->kvm_filp->private_data;
> > +	if (!kvm) {

Ah this I don't think you should be doing. That needs a helper from
kvm

Jason
