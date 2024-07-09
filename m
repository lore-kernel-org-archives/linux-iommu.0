Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF837F476
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546607; cv=none; b=NE5FX+6VDhMceq5OEWLcsNFx69tg1z7Nns/No27/QxVglTZM97eRds8Ogrd22hfU1WepaVhvTQuWDzFFP828w1zBr0g8NrAQLld3u69HjYmhfViRDMugDR5Hg9AA3qQATgxZclFQpRIknKV7vFJ5xl18UclQzVm+PGU8xqgaBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546607; c=relaxed/simple;
	bh=ybUpRykbhepziN9syApY4S0KNYPzhQzyVpqfFsxbFkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToebmOkyrWa8T5z74ae4QrUEjOkXFw/UHn/6XEjhI7ocKGom8yeg5coUhjFmrFCBTt845dGNbhc2KnoHGJ1uqpvCoNHOoY+CpZ2NmruGHFSTLpfQjO7w+Nz88iEputofV1HZ2lxU22Qjc8awLJV9yuYrmC4f621VtkyPTvx1pF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PBHd8CKv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PBHd8CKv"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b6176e59e7so10396036d6.1
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720546605; x=1721151405; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=PBHd8CKv4xXxN5oYjEyXQKartxZ+STZuUtRIqKTe+DdCIl+ti8JWvC1DpCES8L0at6
         hdJB8bE89cA8JTRqs6H3kZyuL/iOjSRk2rO0VTA9Sth0HLV+llkgDDPnx3ggtkZVUZSh
         WcCMpyHL8ZMer4/VgxmNYPrekbQin9O1XOt+3FcruY+6mXvlgS6BEuPCd5PupxWiDPiD
         UaJdMU0e2KouUdEDnmcuyyfoGM/4Quqvxu/ox7hUBD7loIznlyCewBkR6EBBWtTHyoWc
         mcl4LYlKT9DBgGiZvonlUoKoyxGq2GE/ovaQbsIRkgmwRXMKHXj97WmUdhgFGkXitkOT
         +F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546605; x=1721151405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ktxBVI1f7SCZNiJbmLEe3WqbtU8UsAv3DUj8UortQs=;
        b=iYnOjDd6/K0aC1DX2JQ8PI5VhUJnQfevNBb2lkW74NimZVzmX4iFbox8z7oJ8lPeMO
         SiBkJEMEwHvNEcVCzVh2jJEsRoQbG9tPhR7mVL1ot3Xt+4krd0UiLYoivvTrg9F5jyPX
         4uvx2SV4DsTDCAyl2Ota5am0iecfUUkFFfMlPZnAgqDT7gmQfNkd0CS7jVEdqfn3XQHx
         CF0bJGzDcoqvJxbkvJqRjG6XVmQmqKEgz6nM5uYFPFlK89PritsIIETeQEJng0OuJZUn
         5V03zN/uIjQgMk/wd0mbJFz4GGHeSNz2bkqZkU8pjKfwXzjLJuiL++H+92kV7NluybKd
         BWiA==
X-Forwarded-Encrypted: i=1; AJvYcCVkOoHrqD2HUyygVL1cA3Dayh58E/usFKepoiVBykB8MT8BM8Ln/fgpDBwINgo0g5FC+M7gVI+FA5k4EGg8Woi/9vkdJk8=
X-Gm-Message-State: AOJu0YxtJGxr+ZWxGQx5ZL8vPnELlr5h0AVVopLiHYKTx0KdhUV5C3T/
	I/duX63NzKvLd2j3hNXxpnf5UUym0uNsPq13tchqMy3ZejpWyleANy7et9jkVl4=
X-Google-Smtp-Source: AGHT+IEey3aVdoUnVEY9s9+wQwMkPK21WmHGPGMn7kqGKdsDHciJdWQY/uQZYPc75ra9uDqujYUDpg==
X-Received: by 2002:ad4:5d6e:0:b0:6b5:7ee:1d79 with SMTP id 6a1803df08f44-6b61bce1891mr38703216d6.26.1720546604791;
        Tue, 09 Jul 2024 10:36:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61c40e5e7sm10084406d6.72.2024.07.09.10.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:36:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRElf-002kZ7-8R;
	Tue, 09 Jul 2024 14:36:43 -0300
Date: Tue, 9 Jul 2024 14:36:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20240709173643.GI14050@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>

On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
> On 2024/6/29 5:17, Jason Gunthorpe wrote:
> > On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	struct device *dev = idev->dev;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Once we turn on PCI/PRI support for VF, the response failure code
> > > +	 * should not be forwarded to the hardware due to PRI being a shared
> > > +	 * resource between PF and VFs. There is no coordination for this
> > > +	 * shared capability. This waits for a vPRI reset to recover.
> > > +	 */
> > > +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > +		return -EINVAL;
> > I don't quite get this remark, isn't not supporting PRI on VFs kind of
> > useless? What is the story here?
> 
> This remark is trying to explain why attaching an iopf-capable hwpt to a
> VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
> a response failure will disable the PRI on the function. But for PF/VF
> case, the PRI is a shared resource, therefore a response failure on a VF
> might cause iopf on other VFs to malfunction. So, we start from simple
> by not allowing it.

You are talking about IOMMU_PAGE_RESP_FAILURE ?

But this is bad already, something like SVA could trigger
IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to memory
allocation failure in iommu_report_device_fault()

And then we pass in code from userspace and blindly cast it to
enum iommu_page_response_code ?

Probably we should just only support IOMMU_PAGE_RESP_SUCCESS/INVALID
from userspace and block FAILURE entirely. Probably the VMM should
emulate FAILURE by disabling PRI on by changing to a non PRI domain.

And this subtle uABI leak needs a fix:

		iopf_group_response(group, response.code);

response.code and enum iommu_page_response_code are different
enums, and there is no range check. Need a static assert at least and
a range check. Send a followup patch please

Jason
