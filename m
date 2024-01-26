Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE821DA37
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283871; cv=none; b=U7VyjdM55kpmpqdhnxw6ZAvSNWPv0evktaFA1H7U2wFoUb1VdyldG7Gl35oqe3JNGEoZoq1NufUkwF9vOQXaCNUUf4g9doHFo0hGN3z5jcgvg263rWXSEnf8CD/fEBVPy6uL9n3vmTFCV7emv+/1wEd0v4Im52qafecrSNmNQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283871; c=relaxed/simple;
	bh=UiLdiIVvMb83SWw7AGXvISH8OI0rahijuASgroB/Hlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFCRr3jWYBrrZUFc2pqRnXIjotSqRdomAdwtfRUSwCqScOLIhOXBXyf0G30QSS4bFNgvtMgf+Xy492mIldp+yBO7UTMxGeuQy1ruep9abT55EkGpE8Y3/IfrtOvojjYY2YOQwIL5C6xKzykD2fVP8pnNUg1o/FfVcCVVRrbJsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gPPgMTm7; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gPPgMTm7"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6de424cef01so273285a34.2
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706283869; x=1706888669; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifj3vKt8QC0k+Lvrl/eE4vaSsPq+S4SksoQKXsBRSXc=;
        b=gPPgMTm75K2cseziOW46cLpianvr7AsSyyg27B9FiNIL8x8T9U/Gv4H9G9/CVPFJ8E
         qTZs1Jdv1Z9GaSlPYI0gIgD/ZA/e2cKJs7AaHIa3RyBQ6BVsDibfWn1UFv+0g6G7ufIY
         MEppKtrsgkCRS+ldYzhSWgMbscKKwDzn88YU2hlBpV+CFNMWSOpVHXQRmZ36ZMRwQ3xd
         kcSddFZX4ug3+8Z7RjTExBbvRDvusKr4t/8cYWLYi+AOZFFFSVrI/Z0cTvKGbtGeKIkv
         GSOFf++txJqx9xClAbjrRIbsag7fKPTdJEr4gwQsyJa/i/SCL6QbF8sPpntQK/qbkC+/
         JNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283869; x=1706888669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifj3vKt8QC0k+Lvrl/eE4vaSsPq+S4SksoQKXsBRSXc=;
        b=YosnihBB/LO9f2jE0rw4ZFiweozG9SckQ2YviFbIO2C2FZdo5DUIXIMdIg0+oQY7vH
         Ddn4PbLLTwAGpuYCJjNml9Q4z06QK34S5P7VICaao/9rN+u5eXyNxVx0srs9LOCwwTd1
         /KQXNEWm/flRtQvsIXQLeiHxbBXjwPPeuH9mc+QI4WQFq1GorSccM3NeTixwhMwJxnt0
         5hvq7BAUn0ww8QmS2Fn0Lgvd5692u/420d3QSDumDbgdueSE70AKL/eO6nMC7vwyQe+l
         645E6qviuvGA8xFk7KMOFpUbAuGaM7hNCgyIoOsMjTycY7e8t2dQ2TFU9VjRdOiMz0qY
         WSLg==
X-Gm-Message-State: AOJu0Yy2RZ1q5NsgFC3D7oVjnlzsnb369Hvb107KB+oCGC+sglz/CEjq
	5ait1oOqa2pO2gwZHG6mQu1WsrNktrqlZS+TdnItKW23m3aztxdiYi2EyZIDNew=
X-Google-Smtp-Source: AGHT+IHvXs9zt8rzQimULCxVKWRw2gBSkFT+WcT7r0xChxJT011B7UN6s63xs55ItZMqKHL08VvUaA==
X-Received: by 2002:a05:6871:2787:b0:214:2544:bfd9 with SMTP id zd7-20020a056871278700b002142544bfd9mr955769oab.43.1706283869008;
        Fri, 26 Jan 2024 07:44:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pl10-20020a0568704e0a00b0021837cadf53sm200549oab.39.2024.01.26.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:44:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTONX-009SCu-NX;
	Fri, 26 Jan 2024 11:44:27 -0400
Date: Fri, 26 Jan 2024 11:44:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu <iommu@lists.linux.dev>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	aneesh kumar <aneesh.kumar@kernel.org>,
	naveen n rao <naveen.n.rao@linux.ibm.com>,
	jroedel <jroedel@suse.de>, aik <aik@amd.com>,
	bgray <bgray@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	gbatra <gbatra@linux.vnet.ibm.com>, vaibhav <vaibhav@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126154427.GB50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
 <20240126151701.GZ50608@ziepe.ca>
 <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>
 <20240126153806.GA50608@ziepe.ca>
 <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Jan 26, 2024 at 09:39:56AM -0600, Timothy Pearson wrote:
> > Just forget about the weird KVM and SPAPR stuff, leave it under the
> > kconfig of the old code and nobody will run it. Almost nobody already
> > runs it, apparently.
> 
> We actually use QEMU/KVM/VFIO extensively at Raptor, so need the
> support and need it to be performant...

I wonder if you alone are the "almost" :)

The KVM entanglement was hairy and scary. I never did figure out what
was really going on there. Maybe you don't need all of it and can be
successful with a more typical iommu working model?

Suggest to tackle it after getting the first parts done.

Jason
