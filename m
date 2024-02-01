Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8EF15CD52
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787170; cv=none; b=i3PWl0oCxNuQMXL4w70GU+QRqT2zo0Rt2nMyLCEM2NWeTmHrHRBrcpU28tL89ysuC2rwHbLNuW8pYjJPDVW8S7Jl8TTGOFRJIdv4AuhVsVtFjcWBSCTPjjFY0U1RhfaGt8tdFGOutvsV8J7PMpYPYypxKaPq7GuRztXm0gM3hFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787170; c=relaxed/simple;
	bh=bObdFGyb4XR5JUR/mYc8C06Vh8Oai2uSZm11G96WbS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPBmNhuqtbYDQOlUdifBlkHwOnJpX3wtbCRTpkG9jcynfwZafFKD1QbmBeXS07jwGhP7xIWJY196Ar6dgfue3x4bBLIf6HLOL/IKtfPT9J5yRh52hVJxB43/K2P/gvIuxK0i0ozExF/AmClerwKht+zdUHeZoODDJNDfkx8zMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1O9QpuB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1O9QpuB"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so6692a12.1
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 03:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706787167; x=1707391967; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CrwCCulzAZnAs96gqjnErBq9nxxONlGGkgN484AMyzs=;
        b=F1O9QpuBMuOltDZ/rZXCCPoe0p+h43rN0Dl0LgbkJLaX+7yBRPPyrTZ3OSDW2fK6HX
         jp6y+5ftvKO86gmj8G+TecyZKeBNji+YJKRUHNRq/F4a28aQQ6+0sVyBclhzsliZeOvu
         5xqndJKMjsyEl4dDVDpnDQlzNHf8AvR8sekYlU18XC2fwTTG2Iy5XQtyfkabPmMXYEtS
         Y8YPr0tv24hBOFnZDC7k6HrTUSFx1iIGBdZaJG57VMdh0/+1ezQcvVGlFapb7zFw7od9
         OazedpIk+HbBMg0zyYBTxTiscboML79N3LL3ALBsx/txyTCSC9dOFZRTeF/P6/oYP1bZ
         7lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787167; x=1707391967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrwCCulzAZnAs96gqjnErBq9nxxONlGGkgN484AMyzs=;
        b=wKWHoGnEevq5BdZcOip31YQXMRz1RgNXOEq4OojPR9bqYqOfsAYc0CeMQpqXDu1lcP
         fpQsQv3FRklEfFhh1iamujpp2KT9qHkqpnm6ZkNHQUzfbtIimouX2JxogaqLFRdfPl6Y
         7Zs5rWKQvCOW8iCF1gas5Z6HsANqN9yGRK7Z9BtRQYnxUtoLlSFC6EJGzV0Y9oj7QInU
         CHKT78rk0BiXH2tRkNtOp0LXg4Nsydwgze/D9qQFQKTRJLQ4QHRm7LVNgpVx45JSpRB9
         roI9orf9PPrABCzJuOA2d1yiL4rGcIz4nxvYZn+2k5Jt9lBzBw7lhHnysCLDi0jUnm1T
         5Kng==
X-Gm-Message-State: AOJu0Yz71wXDVl5sJQm0q4mjzhCY2ZJP7ImwUcRV30uNmSaP9QZ26EDz
	g8gmvSIzc5XuYh5MlPuDTKkC812MdB3oaxm6bIRAoHlCupWzg/fKgw0/GVRCFw==
X-Google-Smtp-Source: AGHT+IEjvpIoPji94MqIaJYLCjq1Hn0GpJ+tQil3qpKubdKI7Ln972WFpTBRnFPXOSJ++HZ9Wppvrg==
X-Received: by 2002:a50:ccd1:0:b0:55d:2dda:f331 with SMTP id b17-20020a50ccd1000000b0055d2ddaf331mr142084edj.7.1706787166711;
        Thu, 01 Feb 2024 03:32:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAlcbtAml4rt1aYRO/OVlP2ZVADD0Q2ekKOzLsTkmpBKffiAwhXG4LjATEUfZcWfuKo8AH45cKcOIQW8jnpmxW/RXouwTcgWQvqGw7RhmIQeD53uPersgKl2xXN3S7c6JJMzt5u56DVYAxo186601THudStCi/UF01VYKNfk8ArLo0dbgGvD44DAHTbYaJak6POzNLQdKuNqXKcPS7tHnGOceUujMuAjxyv+zbxflXvZJWVe2vrRj0kz3V3McZ8YlJvwBf20AjV+j468b1lRo9VakU0in05VFF8ATUPwTzOk58myr5UViEEDMJFH37vzaV+p+sKQxSsWOI3j4ls0GMExiSwPsYiLXBuodK3itNio2OemGU/52G
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id ps10-20020a170906bf4a00b00a368718314dsm1289315ejb.7.2024.02.01.03.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:32:46 -0800 (PST)
Date: Thu, 1 Feb 2024 11:32:41 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Moritz Fischer <mdf@kernel.org>,
	Moritz Fischer <moritzf@google.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 02/16] iommu/arm-smmu-v3: Consolidate the STE
 generation for abort/bypass
Message-ID: <ZbuBWQNEDqlFAoFi@google.com>
References: <0-v4-c93b774edcc4+42d2b-smmuv3_newapi_p1_jgg@nvidia.com>
 <2-v4-c93b774edcc4+42d2b-smmuv3_newapi_p1_jgg@nvidia.com>
 <Zbpb2JSgnRuHGIo-@google.com>
 <20240131144702.GJ1455070@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131144702.GJ1455070@nvidia.com>

On Wed, Jan 31, 2024 at 10:47:02AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 31, 2024 at 02:40:24PM +0000, Mostafa Saleh wrote:
> > > +static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
> > > +{
> > > +	memset(target, 0, sizeof(*target));
> > 
> > I see this can be used with the actual STE. Although this is done at init, but
> > briefly making the STE abort from “arm_smmu_make_bypass_ste”, seems a bit
> > fragile to me, in case we use this in the future in different scenarios, it
> > might break the hitless assumption. But no strong opinion though.
> 
> At init time, when that case happens, the STE table hasn't been
> installed in the HW yet. This is why that specific code path has been
> directly manipulating the STE and does not call the normal update path
> with the sync'ing.
> 
> It is perhaps subtle that is why it is a different flow.
> 
> (this is also why I moved the function order as it was a bit obscure
> to see that indeed all this stuff was sequenced right and we were not
> updating a live STE improperly)

I agree, this is not an issue, but it was just confusing when I first read it
as “arm_smmu_make_bypass_ste” would make the STE transiently unavailable, and
I had to go and check the usage. Maybe we can add a comment to clarify how this
function is expected to be used.

Thanks,
Mostafa
