Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C8440C
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818526; cv=none; b=iZx7tX+hnaNOVABN8ep0+P1QP8C0j4I2hABp/1UPJTBuqfIPr2zMRuRKFH82Zhz9P/08JKGwTB0cUnBK9sc7hkv8hfU5wKgIoVjWSxLe63IJB6HTzET7SoM9WMG0Zlrwpk4LAxf1PEXz/TuVPDA2I/v6mszYIYIB20/X0HK10Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818526; c=relaxed/simple;
	bh=NF/1irqy4jJ1L6V66mqdBPhra41pySte+a4okmBQcdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1sCnYgla+puEVDy1rrchec1HxK7rSZ1/vuV9pedelufwSpStzNFVkNw7/jbRXDE3SsocN1vqooaoQ/Gt0bNOP5f1GgFrAmgNQuUFFMnj8MtMVPUKAjHy439FIrvKkxhTqVjQxJq7zuFrSJqcOyTCnRdmeMwsnu2VVpGlOW6iOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P72qkf6e; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P72qkf6e"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58f79d6e9so25325791cf.2
        for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749818523; x=1750423323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jl1a0a1dTiH9ND4pj3QHpu2/HcDZNYc3TWBsAo2QFhs=;
        b=P72qkf6eGVn8XmozBBTJ+AmchCODCDxDSRHln4Yss6Y2PRN/1FvIYH221itEAk3Dey
         /esuwlqLugc2+mhxhfHjK/T1FMlhw0n/2XWzc5aNRTV+wEPAzG73iW+f4G3+NWJ4DCi2
         LiBYsZS2oGNLaDEmRnsKMHLuYQnPSDiJU+1oNkp2vhha4ag+/zHj/F3wPF2zhAe0N6dH
         fi56qRPKh52zuadkaEXiAObGeMXUN3YwepE0ECxh7EpCI4aYNsSl0Y7Wb57fa9IlmTxN
         fztVV5fYi+afXrQ+Z72NN7OhBwWBljk/Q0ktsr++Z0Oiw1hsYIIRtWeJBydaaqYLo/aY
         Y/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749818523; x=1750423323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl1a0a1dTiH9ND4pj3QHpu2/HcDZNYc3TWBsAo2QFhs=;
        b=ji3EIlsXCR2YDQ3jrJmeWqVz8DyLOdpy2nKjstaOL9TAlpzKmYYZANzDxNGXU1d/EM
         7PXTCtnCTqopNzgi2cvM++neMu508NChXrW69iYNxyPOdfeB+uSAWAM+xVtQC8d5FLs2
         bMyFBhnm/QAOD+JHD7aZFo22p++yxSVLFOHArypxYDgO70qlh2CaHvKTNaHHzay6VfEw
         NWadX81j/Cp0BYZ7zSLNKjUb+t/c4yV9149qep9Z5PUcKlWpK6f8psPe59T01T5PdQyK
         ML8ZCRzUzvXuznqL6wwpAwLSwV0/Z/+/K7E+0EBLraHVWrkqkOtXLfXlBlLtjRQeaso1
         kOXg==
X-Forwarded-Encrypted: i=1; AJvYcCUXhiOAYM+xGtW7PTZIK/w7vhJ3k2nkiYDCUgKgY8nOS3FA7HcZFLw9vl78ZdYQCGKmyZIE1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxixZTcWJZh9WFl7mnAePtXBa2bHpPVcnZ5z+hNv2HwtVsUk+LA
	PuZrIg3Ih8yI/kYD1dr54A0Y/lbyS9VIbZi8S7Oalg4bMvHM/jfLlmNiF+vLpxnJgTo=
X-Gm-Gg: ASbGncuAvtM3bQUUrVwqZbCk530pePPB4kfrNWmX7wqJy2QuunpQ6rgFyQ0MPlFAtHz
	TFhy58yEHpX/z3EgD7fdkym6+9uEGd6WAZ/p/fs/d9shbNrEZjhPnkZBxAwtECbPeQqpkugBLqi
	EedwHruQfFlVdIpKtujt/tm7DPEwxPk2ZrfC6m1RqgQliHgm+rwDAqtUce2yqH8Lv3BgMaQc7FQ
	VODS6GjOXGdIjeyqyuXorlDotDcIc/ypuYeODw7IBtl0q8Bbo2XFKoFOA1eD632P78ep9/bGBBE
	uolitlTKpQ6itcm1xp9bT3wLrjAM1lF3tJg0beTO8JreOu2ROmvm3gzNv/Po14On1r1ZOp3OFuS
	H3NVj31zDOOiKFcf/MGlohD9tKNIt9FSTWuv3a0Od29qVn0Tt
X-Google-Smtp-Source: AGHT+IEMxc1apCXqPdiscCu3+jTMN5egyKcnrKpFBxG3GqFbDqJieLgrbOGckcJ4ZD2K8JgzUZhGZQ==
X-Received: by 2002:a05:622a:1e85:b0:4a4:4af2:5cff with SMTP id d75a77b69052e-4a72fe5b8d7mr51010151cf.3.1749818523244;
        Fri, 13 Jun 2025 05:42:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a50985csm16302801cf.72.2025.06.13.05.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:42:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uQ3jO-00000004qLu-0nK4;
	Fri, 13 Jun 2025 09:42:02 -0300
Date: Fri, 13 Jun 2025 09:42:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <20250613124202.GD1130869@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 13, 2025 at 07:31:48AM +0000, Tian, Kevin wrote:
> yeah that seems to be the option if the said life-cycle dependency
> cannot be removed...
> 
> conceptually it's still a bit unclean as the user needs to know that
> the vdevice object is special after idevice is unbound i.e. it can only
> be destroyed instead of supporting any other kind of operations.

I would say userspace is somewhat malfunctioning if it destroys vfio
before the vdevice. So the main aim here should be to contain the
resulting mess, but still expect userspace to destroy the vdevice
without a failure.

> hmm if the user needs to build certain knowledge anyway can we 
> go one step further to state that the vdevice will be destroyed
> automatically once its idevice is unbound so the user shouldn't
> attempt to explicitly destroy it again after unbind?

I would assume a malfunctioning userspace is probably going to destroy
the vdevice explicitly. If it had proper knowledge it wouldn't have
done this in the first place :)

Jason
