Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540AF216A19
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895324; cv=none; b=acPyrMkkdRKSzU8Mg6s+E605v2Qb8zAFq79OIQ55T8FOioBAVaOSTnpURvAlPz7kBIvC4GQHwipiDwT47FTHCs/gYhrr10Y/gVID+ipFgGQaksw+pXPXkdpGnYO40nM8B8ItyeLNim4hZFavGQq+mJ479HRLP77waZHUUIF1bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895324; c=relaxed/simple;
	bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgHWHqIcpSr/MpkrnHQa8TCLDbMfzqtvy63zYzFNmUNgW8SJktcKw/wrFc35XV1KYkBNrqZJ1MNGYHZ88dyRMQR6iIKUmcWZnIubKD3fd75yQ4iT6FPlLM7kQXc0uDL+XIY5of1xkKxSPiQQqBOxks7BqzsiqKVXPMzX+1ajuWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RQl8Y6Om; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RQl8Y6Om"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25cfe70b37so130080276.1
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727895322; x=1728500122; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
        b=RQl8Y6Om6vKImTD9WikLPZDEQRFnXcgHlnZuxCYNW+dS2GhwqE4PIFvWi22EKmUajj
         yXsu4XAQY3UygsA8AbpeXvOew0Rwe4W9rXnypxoV2O2NjNIyDi0C26emRTGZ+HI8bt61
         s+Fxe1kFCNOxTPiKGl7mGonw48ljxJT6gWM1YHmesA6q6lxyzplclwGTSjNOwd4bPIfM
         P9tCcqlN8l/EDFlOFCW4b/ri/SjKUEU3oNECZzNGUlNWBbJ8hO1KDVF+0bzfyBCDUoHL
         A2KSYcdrByp8QLjQER3fxYdSHsly6hOOLpiKAqfbeYw1b3e52SEEs3/fkLRaOUsTpzO2
         8+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727895322; x=1728500122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ElWqU503cDmthQrkETKoibn+yxrDRTlI0NA4DOSxVY=;
        b=q6U2AvNPxTKLW/zhygy8YNsIrbawxo2RHntUhMIyOescYsThj9QpZY4ZknmC9rIYOZ
         Bwbz4WUlGzn0vL9KqYD34l9iI/8X3vrjx1kQ+1i+1KI/bViym3I2O5tIpDJcaqi1pEqD
         cTqJLJbV8ZdpEyHVELaTTwos1hL0YriR1qcGrf0iLKS6lNHRofMSagIRp2Hm/STig3hM
         okA+wMQHvp7WIthg2bA0ZBZUJb96dOs3/Wj+fuQjuyj1ghRTuWzsIzjQTuz31iqpS9J4
         O3Ue6CvbZWppdsfWIO/xO34VUlywU+aO5FufidGLXV6xPbnC6MKwsWZhKCQZ1uc98oeD
         iPvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVHOTS0of+1EOZvBmWFEQGBy7cqM7t56tkyJRR5j1vXSKu8WPEMHWcvHdFshPJmTaE82vynw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFJEa5uZoCTjPMniKEC6OVFyvE4cNae12R7eslDtm20HkaBkzb
	CJHxK77yeUhYH5uzT2zV/nldLiPX7LOKvkP1mde0A7YudXaO0RTOij/hSyy4Ej8=
X-Google-Smtp-Source: AGHT+IE/4YDKGNMGbzf1cBV3ciJ6gTYpbDOAXQ+3Q/QHeGIUP/Ee9BC7INUAzJEGFa5vHK8ha9AvWQ==
X-Received: by 2002:a05:6902:1002:b0:e20:268b:8ad0 with SMTP id 3f1490d57ef6-e263838509amr3699684276.5.1727895322247;
        Wed, 02 Oct 2024 11:55:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d74dacc1csm20873031cf.36.2024.10.02.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:55:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw4VM-00AAFG-Sb;
	Wed, 02 Oct 2024 15:55:20 -0300
Date: Wed, 2 Oct 2024 15:55:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241002185520.GL1369530@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-6-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:30:54PM +0200, James Gowans wrote:
> Now actually implementing the serialise callback for iommufd.
> On KHO activate, iterate through all persisted domains and write their
> metadata to the device tree format. For now just a few fields are
> serialised to demonstrate the concept. To actually make this useful a
> lot more field and related objects will need to be serialised too.

But isn't that a rather difficult problem? The "a lot more fields"
include things like pointers to the mm struct, the user_struct and
task_struct, then all the pinning accounting as well.

Coming work extends this to memfds and more is coming. I would expect
this KHO stuff to use the memfd-like path to access the physical VM
memory too.

I think expecting to serialize and restore everything like this is
probably much too complicated.

If you could just retain a small portion and then directly reconstruct
the missing parts it seems like it would be more maintainable.

Ie "recover" a HWPT from a KHO on a manually created a IOAS with the
right "memfd" for the backing storage. Then the recovery can just
validate that things are correct and adopt the iommu_domain as the
hwpt.

Eventually you'll want this to work for the viommus as well, and that
seems like a lot more tricky complexity..

Jason
