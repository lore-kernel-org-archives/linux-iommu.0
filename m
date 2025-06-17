Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B92219A79
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185296; cv=none; b=MFjt5bnlxGJOCXt09JwpRPvldV/TycW6pGdxLn8/EOjrck3LvrZ5OdbM2b31OZScK0nLfHjL0jQtz1PFqXwLU9TSXvf/DKLtZvIV3QfXz7pjNKeNmj45ObYov8R8pl7mfywTCADuAR2FkqOiY7kMV4JrjtaPg6HV0TTQDXrZ9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185296; c=relaxed/simple;
	bh=vNXK4oDmkZ/5vEde1tk21+hvLrX1mK5D+uSj7F3uoxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKX+iug1xa71POz5VVAgV25xRwKjCslHYTAXGw4E1g131YouqEyb8KDFjIQS1XWAT0uMK33yrF6ngMNKa6Km1ktI4RImJqRVZkGy7QvBt5CVSVnhHpWo8cZFkVsvJhoWK9n/khbpCMXs1NE4aaESS1C2dLhgq+Bq1fE/HnJezAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nH2M+Qvn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nH2M+Qvn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a4312b4849so70031941cf.1
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750185294; x=1750790094; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkUw7K1fNTUFr0XSmkjhiZVRjINQnKgrdCWIYf4LhiU=;
        b=nH2M+QvnvhpYZdmnNrUG66sBdm0Ui4O1y+7gr1bNa6aquL4dIR470zxmbR6QEMQZSM
         +qVCDq+FnqsOVwW4SAcYuJliM9ek+2w48X58ycd991BYI/pSxrP7jwYgKhwu0j6V3z2Z
         cM/DU2d/CZVFXEezdJLisxl/LBhmDILeaL2pLZjjDNymf+mTU0gA59X0V4pdo3lKFGGC
         Fg07/4/RVgN3G8HMB87aW4JfJGjU66KY5tOQr6WUsg0fJjESK+P0KKUZ3a2YULQcTRWa
         RluEAktij16fF0JzqcvQhn/FluQaVvIIJ73ollsEfwAWTsyw1KfnGF1Oum/6QPHxNaz4
         k8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750185294; x=1750790094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkUw7K1fNTUFr0XSmkjhiZVRjINQnKgrdCWIYf4LhiU=;
        b=BX87/RvL9oNBIWM61QTf/5c90bY08kDWK3isu3Zi8I5f+hslkdt1YBcnlDfjdZfm5g
         HrEJbqtl0vGGOPRTwZ53ch8qcJkIfkTwneebJrJo7j708Ti/Cacix112NPCRM0HMuVk8
         m22PcSZNI+oBpSB+Mjv+sbSCUoYZOhj5qugtsp36wa5bC2vgcvaEQvZIIps21kvuiAoP
         1/kLrJ7x+A+nHM+VKYz8jLgiNQThqZOHkaQ0K91DJ7XhDfIhw37dqSdKCVqspLqouw44
         xywBjmyUPN3DWdHav2zzHodEHYcetmFA8S+9Y+RICcsFOL7CFXtvjkJiF36XYMnNNgBc
         X+MA==
X-Forwarded-Encrypted: i=1; AJvYcCUlhpXb0SvnTJH/aVfHLtawv6F0uMjiHkvPEKLJoZ8krPWy3guDAaKRalieoDlZhjdP47ZSlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxV4nLAKXp0zZvjO0yOhm25CQvZ4kn+p1aR2st44WWqQgxTleGg
	OhtuHzmwl3jOb7WcN17VwVEcfiFeBLSTybJDAlDM1uguMZnT2aYH9K2VVav4fHAqdmFm71dfg23
	+gHlS
X-Gm-Gg: ASbGncvGZYV7pMVTHUFWjXNCTZLv1N/7wAJcWAZiW+RA7RnFNdlDs8DxJhaFyEEdioI
	oMQR4Nrm5SRshlPvQYEtQ3i7iiohzqoJzFR2MVDHUT8lXz80Uc0EW17DruEFvo4PQPNpe4Fm+Nu
	hwzW/5ASkTHsoJqUs+a7xTKK2MnHdUHjXaAwF2oikSJupFNQHEu8jcNVX/mNs3QHzc264ISv6eO
	ZS2ZJyTZa6edz1jUBjaANHrr/Q7N6Tu//WvZMjOPBi1awTzrgIkEvEcOzFpAKEJhmfng4Gaqb6i
	piZ4vCszOIylcFDRoPqDOEWk3hH6vNmMv6i/znca76O2bmK/kfafmkpEFVjeoN0+Acq6caQ8uGX
	kiy8D5vuYWi/gQ0hjP65Dt0AMTBG7oGm0GIb3yA==
X-Google-Smtp-Source: AGHT+IF+gpQV430tU9VpFbWOEEO9nCtbhkf7JKZT2vfz8vbnYNPhZr+BRPLWyOfEF+iclrfKMJ7agA==
X-Received: by 2002:ac8:598b:0:b0:494:a2b8:88f0 with SMTP id d75a77b69052e-4a73c589061mr236405141cf.33.1750185293762;
        Tue, 17 Jun 2025 11:34:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b0cb9sm64018831cf.50.2025.06.17.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:34:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRb92-00000006bm4-2q58;
	Tue, 17 Jun 2025 15:34:52 -0300
Date: Tue, 17 Jun 2025 15:34:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <20250617183452.GG1376515@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
 <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca>
 <yq5azfe6ssev.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azfe6ssev.fsf@kernel.org>

On Tue, Jun 17, 2025 at 01:37:04PM +0530, Aneesh Kumar K.V wrote:
 
> How do we reclaim that object id for further reuse? 

Maybe just don't? Userspace did something it shouldn't, it now leaked
8 bytes of kernel memory until the FD is closed.

> is it that if there is a request for a iommufd_object_remove() with object
> refcount > 1, we insert a XA_ZERO_ENTRY and convert that to NULL entry
> on IOMMU_DESTROY?

Oh no we can't do that, if the refcount is elevated that is a problem,
it means some thread somewhere is using that memory.

We can sleep and wait for shortterm_users to go to zero and if users
is still elevated then we are toast. WARN_ON and reatin it in the
xarray and hope for the best.

So the thread that will trigger the detruction needs to have a users
refcount of 1. Meaning users needs to be one while idle in the xarray,
and the idevice destruction will obtain a users=2 from its pointer
under some kind of lock.

> -enum {
> -	REMOVE_WAIT_SHORTTERM = 1,
> -};
> +#define	REMOVE_WAIT_SHORTTERM	BIT(0)
> +#define	REMOVE_OBJ_FORCE	BIT(1)

You can keep the enum for flags, but 'force' isn't the right name. I
would think it is 'tombstone'

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index b7aa725e6b37..d27b61787a53 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -88,7 +88,8 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
>  
>  	xa_lock(&ictx->objects);
>  	obj = xa_load(&ictx->objects, id);
> -	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
> +	if (!obj || xa_is_zero(obj) ||
> +	    (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
>  	    !iommufd_lock_obj(obj))

xa_load can't return xa_is_zero(), xas_load() can

We already use XA_ZERO_ENTRY to hold an ID during allocation till
finalize.

I think you want to add a new API

iommufd_object_tombstone_user(idev->ictx, &idev->vdev->obj);

Which I think is the same as the existing
iommufd_object_destroy_user() except it uses tombstone..

The only thing tombstone does is:

	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);

All the rest of the logic including the users and shorterm check would
be the same.

> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -213,6 +213,8 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	/* vdev lifecycle now managed by idev */
>  	idev->vdev = vdev;
>  	refcount_inc(&vdev->obj.users);
> +	/* Increment refcount since userspace can hold the obj id */
> +	refcount_inc(&vdev->obj.users);
>  	goto out_put_idev_unlock;

I don't think this should change.. There should be no extra user refs
or userspace can't destroy it.

The pointer back from the idevice needs locking to protect it while a
refcount is obtained.

Jason
