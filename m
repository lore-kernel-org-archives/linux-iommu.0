Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F924689
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890154; cv=none; b=PSxWK0QCWpfM1iZuMcn8fq6axXel5yUcuqSe7GbqY3XQQMxOOFwY8Tax2hSb02tcNTxeYk376kzuIwS+dQ/bAo9YmoA2SFD/tJQUDYNQmht3FOt6c4oeweGqzHPGELHSrphS1rYxVK1GkFUKMUes41u3tn61sPsa7wthJbueQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890154; c=relaxed/simple;
	bh=pxYzwyTErxav4kVlQNYYa4Y6+SVLoPp+wWMf8HlP1cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czYgqPt7n6o/NLPiFG0S9bF8Z02caSPABUn0FWYCv1C6hrCbimRQ6L9nIKIN39hOp3H91FBQREb9NvR3e0C+NVY5NAf7MS7b5mZ74NBYDGGwv7KsDqCKv9vxKxjPydE272QU4qGou0KyW0Ft+1uduq2MegOTeQZQYaiOuRshYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YL882uD0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YL882uD0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf775d1bdfso461596d6.1
        for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724890151; x=1725494951; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FV7jma2FtOFkk+MQPyy4nsPLobzuy3OnZDyRuJH5ziE=;
        b=YL882uD0iLVFH464JlpsJIEC7vNB7ph5/68ILPevsRuKtbbYQqhp+ddbYO0tFMSocg
         pyC3RBjAtSpupMYK6zgsTTDiCe+hsbBuxlDcTfIOG60Zgqks482mJNLVvEkvBa7ppdXN
         nV1Vq8r22qRHPmoKd8MX5KJbRJOSZg+ug3fZWyejpTh1HMEL1xsR2IkHhcqPWGBYx1Dn
         j7nLCgZo2nQoQyMoLp2u+krydyeZ9LRdYH7cbeXDn8CknUBFK5+o8KlsVXU/76EcFX1b
         qgPosOIxgM/AhPPOphaEEeNCUsN1RJFz5nAyfbTJjBTKNRugquAu59thOAs/o14QgxNp
         Y9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724890151; x=1725494951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV7jma2FtOFkk+MQPyy4nsPLobzuy3OnZDyRuJH5ziE=;
        b=vBVPiDphLcVSGwKGBiYPYIE7hjQD57s6zIY1nZHBCJXS6KQFgAXH6um/Ze+lzbNQ60
         Ptz7aTOAMcEybZ0lAfGfdlsV56SQyiKqoWbC4xp06xuTAD0fKwT0d318NrlbO/J+AUNv
         LyRME5K9jcQ//y6e87B02EYGTKDXojvLlssn554SOk1Opw/2Wu2JdgzKKJNl9sQD/Lfp
         TIDnGDqZd+SNoxfBhyvJhaheMzJEpTWdMCY4SHjjK26DMC1eWo7jrb/D4jh1jahSvOEh
         mug5gat7UEjel63iDhHyJ9qPsSk1nlWX7FidPAXrCQU0wTZmaZRhjkhAhMRk2sgVZpfm
         HkNg==
X-Forwarded-Encrypted: i=1; AJvYcCXrBHfndCa0MSNRwZpfYpqNb5JMIoDcxJ5iqKWU31SPsA2y6VFuIQqCsJBzj+313iiSfI9RGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnVL2zETScszYuuiTBu6sdvz6z+lE+ZlhMynrgHfJe5Tw7zlpF
	1Je0mEZWpXDFrd7ZOnJPWn474qNvXc+9dLGLvERW0sNjOim5Y4aKWPKvxfh5Bpc=
X-Google-Smtp-Source: AGHT+IHqw/vGpYZD+OWelu8nPkB2MgoCednN65b5E9RauNOWKDpklZXRAeEUm7fYZsAKjN6LMvW72A==
X-Received: by 2002:a05:6214:3d10:b0:6b2:b9c7:da6a with SMTP id 6a1803df08f44-6c33e671571mr15520156d6.41.1724890151363;
        Wed, 28 Aug 2024 17:09:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa74esm648816d6.6.2024.08.28.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 17:09:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjSis-006P2S-3t;
	Wed, 28 Aug 2024 21:09:10 -0300
Date: Wed, 28 Aug 2024 21:09:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	pratikrajesh.sampat@amd.com, michael.day@amd.com,
	david.kaplan@amd.com, dhaval.giani@amd.com,
	Santosh Shukla <santosh.shukla@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>, Alexander Graf <agraf@suse.de>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC PATCH 07/21] pci/tdisp: Introduce tsm module
Message-ID: <20240829000910.GS3468552@ziepe.ca>
References: <20240823132137.336874-1-aik@amd.com>
 <20240823132137.336874-8-aik@amd.com>
 <20240827123242.GM3468552@ziepe.ca>
 <6e9e4945-8508-4f48-874e-9150fd2e38f3@amd.com>
 <20240828234240.GR3468552@ziepe.ca>
 <66cfba391a779_31daf294a5@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cfba391a779_31daf294a5@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Aug 28, 2024 at 05:00:57PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..]
> > So when I look at the spec I think that probably TIO_DEV_* should be
> > connected to VFIO, somewhere as vfio/kvm/iommufd ioctls. This needs to
> > be coordinated with everyone else because everyone has *some kind* of
> > "trusted world create for me a vPCI device in the secure VM" set of
> > verbs.
> > 
> > TIO_TDI is presumably the device authentication stuff?
> 
> I would expect no, because device authentication is purely a
> physical-device concept, and a TDI is some subset of that device (up to
> and including full physical-function passthrough) that becomes VM
> private-world assignable.

So I got it backwards then? The TDI is the vPCI and DEV is the way to
operate TDISP/IDE/SPDM/etc? Spec says:

 To use a TDISP capable device with SEV-TIO, host software must first
 arrange for the SEV firmware to establish a connection with the device
 by invoking the TIO_DEV_CONNECT
 command. The TIO_DEV_CONNECT command performs the following:

 * Establishes a secure SPDM session using Secured Messages for SPDM.
 * Constructs IDE selective streams between the root complex and the device.
 * Checks the TDISP capabilities of the device.

Too many TLAs :O

> I agree with this. There is a definite PCI only / VFIO-independent
> portion of this that is before any consideration of TDISP LOCKED and RUN
> states. It only deals with PCI device-authentication, link encryption
> management, and is independent of any confidential VM. Then there is the
> whole "assignable device" piece that is squarely KVM/VFIO territory.

Yes
 
> Theoretically one could stop at link encryption setup and never proceed
> with the rest. That is, assuming the platform allows for IDE protected
> traffic to flow in the "T=0" (shared world device) case.

Yes. I keep hearing PCI people talking about interesting use cases for
IDE streams independent of any of the confidential compute stuff. I
think they should not be tied together.

Jason
