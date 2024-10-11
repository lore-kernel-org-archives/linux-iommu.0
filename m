Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF9209F46
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633241; cv=none; b=t+WKZF1cKjEcFvyswAvv0aGnW/II9m8J4EDFK28Cl18oQOYJISN5bvdviBNevoHt2hEXzFejvdKN/PivE1C8Wtlp9GJ+UC033NpycWis4FsBUe8oprhT9aGbhVbCpsUDg70OZRJKYKKW+75AMfKDH3aPmy3eD3oscWPhPK4y1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633241; c=relaxed/simple;
	bh=yb2Sqohc4GqvbMwXNIVtJhJt4mY1oyFteMWLvTpGfEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAjMwgugI7u8nZptyHEKpFtG3Q1+WrFUTlSA9/dI/rwq2if9914gJFClhjGDH7FPxJmr5ldKXK+7ku8m9T537D5pUb0Cl293Gtw1JpIW2hA34E5+ntjslmezSOXqhITEa87GXbaPuvBvOGX/MwgiUvDfneF6iZaNgC441B6vLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aE/BDksr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aE/BDksr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c87b0332cso107765ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728633239; x=1729238039; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NsmMSYxw2uRTtGppNE+tWHwjNvRd5Y4yCjRMVw35t8=;
        b=aE/BDksr3z3sU+N4XvLjhb/NnRY47NI1e3+gUzDu+mPdRhBvlLp/Dv469ZCF0EzFe2
         +DM58nQz0mrdLPjzi2K3h0sncHPW8jfiLTw1m0VXruJO+4Xp5vJ/Qm2+0r2y0+NHu/AP
         ENQeFV5s+7i0ZU7Oh9cqk05kXEn+pPLMNJmTxxlQ/z6Alx3+by7MSd83Pfe2E4ws8FIx
         n/yNZOmQ9SYf4wERFswS2orbyAj63WdsADZ9l1z7/dDmx+ZROT2k+jucZbJNrOsdE+8Q
         cWWhBYWHJlZzO26LG8jkv9h1x9jwK0sCOzLTYqtOKQOlVINOZUON5xh6U+gPzfOf2Abq
         Gpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728633239; x=1729238039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NsmMSYxw2uRTtGppNE+tWHwjNvRd5Y4yCjRMVw35t8=;
        b=osgrkUKtj4y3s/FypvHHMelkpNo1Bwul6AuzeKFcssPfuGXMniDbCY45SgszAW7T8U
         uL6rUMSICqDhSZqG3XVaS40xvzSw46X3BpODF/nHQ5UMn8I6zy1mmlYNVdNYQYSFHq7Q
         y/zQU+bNLvHS6QjhbP9vjjyzpOwdReaXHWwHMmkbJvCOHR/nDJaWs2C3b5lwYqLm/SWE
         zASbiFkuHfpiwH8tQOZdqcDIVOgAxQts98cXQQJezDo4pTJW8SXQRBrfrgWcjVWxQ65W
         JBmJCCwJik0C4+wsyDgJdE/k2iPRYB4beyheRjTjcv+NnIXSv4CapvYV7lkerzECfC+l
         PZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxlH/VJFSsWIdu+GxYcnt1v0YhQzQhErHAl94geJXCfeulaFnvA+2gAYuRpAWRqYaU6FRxxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxw/nRngcku1HVpLr9DHK6SnEhBJOTesmibbcJz2pDHOoqOkaOW
	v7uBI5fjEq7iwim0EvGtnfTJ1buRslxZ6d6wN5uwO3luvqIf2P9okdwOEiG2mQ==
X-Google-Smtp-Source: AGHT+IHwK31WNAyEHmc1rCjumq5r1VWuKxR7+gL4JDReIHmmNYIjTQrxTVDUd38RqKiNED3uLUIiaQ==
X-Received: by 2002:a17:903:228b:b0:20b:bc5e:d736 with SMTP id d9443c01a7336-20ca1a30e02mr1381905ad.11.1728633238667;
        Fri, 11 Oct 2024 00:53:58 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea49e083d6sm1565836a12.41.2024.10.11.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 00:53:58 -0700 (PDT)
Date: Fri, 11 Oct 2024 07:53:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZwjZjumyCCQJqSVC@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
 <20241002171052.GJ1369530@ziepe.ca>
 <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>
 <Zv8MDB4a_P3Jj6x1@google.com>
 <Zv8fob01iAGP85ov@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv8fob01iAGP85ov@Asurada-Nvidia>

On Thu, Oct 03, 2024 at 03:50:09PM -0700, Nicolin Chen wrote:
> On Thu, Oct 03, 2024 at 09:26:36PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Oct 02, 2024 at 10:22:13AM -0700, Nicolin Chen wrote:
> > > On Wed, Oct 02, 2024 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > > > > > dev_name()'s result can't leave the lock either, at least not with out
> > > > > > some refcounting on the struct device.
> > 
> > Agreed, I missed that! Maybe we can avoid reading the master name in the
> > `arm_smmu_get_evt_info` and move it within the `arm_smmu_handle_evt`
> > under proper locking? Since the event won't be dumped before it's
> > handled, we can avoid locking at two places for doing the same thing?
> 
> Yea, just move the master_name closer to the locker, and put the
> dump() inside the locker too, either of which happens in handle().
> 

Ack, I'll read and dump the event within the lock acquired in
`arm_smmu_handle_evt` in the next version, while keeping `master_name` a
local variable.

> Thanks
> Nicolin

Thanks,
Pranjal
