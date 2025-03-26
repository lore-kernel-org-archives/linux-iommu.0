Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14928F4
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 19:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017770; cv=none; b=TJYXcm5Ptey6NWzqgozU6x/1vlg/ydIwdfLGIkfns5w5nRR2m/kS/li5bYTbHHwaLT5lQVWayUeoJvVxfQygsvuoFZSAo84vSZ7E7wW4955Bv1BMxcwO/OvEEwcnKMu1SfaRXafmBb9p4eHl4ORh7AK2L5Q+h+8wmDKTsz7DHjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017770; c=relaxed/simple;
	bh=nScgvwFJ3EyHex6r/JwF26Z/DszBL15DaPqN6dRhMqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAzTLFepROCznNmNxq++tCOIEGmExPql2vgpKjwjBmmMqwKx2tdCDMuzLGqGiTzebvnB99ooLO/AoKR7MXYIsCo9NXCg5gDnK5Q+Y7gb2yRp+vL1gx34NkqNAuDBsDwtL9zguHa/j+2+o13xuint1FBbFIArz5LY/Wezo8R82tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ix3ogYC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ix3ogYC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso2175ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743017768; x=1743622568; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QTYWlbh0KbXeRWncEDC3pBtK9tMNBas86qof/tXEKa0=;
        b=4Ix3ogYC69T6Xltgp+TriXQtq59eS6o93F3cJJnzzvnrN90lHhe3Bl3sVg4ebniLYV
         FEHTHgAwJXSGYsMPCZSrBchLXr5txz69MEIj20Cmbo5duMakqpafVzeogDDTjXQ6S5Fi
         sZI7TO+C8aA4nbiyH2xVEoLjCMtHU+8zeQJSAU4Ff/WDkq2p9n0gnb0MZKFipCilz3EI
         ZVuMEVsvkxVYND9/Ul45cS+dvFw4XS8xfDMfXENL6cOYgKGBdvu+6qjixWn/Kz5+8Gsv
         NLupndpeAPNLovO0pzc3V/Lq3eniWCcYq3BoGbbchutWMRr+2PnZ2dmFtojGa5rXD5/T
         YmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017768; x=1743622568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTYWlbh0KbXeRWncEDC3pBtK9tMNBas86qof/tXEKa0=;
        b=nTcy3Dg+V+J/2WdyDgkUFbU5pe51Q5xkmiyXWozzZ3sZBJb0NpVI2D0YAdMOS1zRum
         POX6AMMf9l/hw/+Wq6pXJaM7Z01HbJHRjh2ZLBMLsAvpg+Q8Q1BV58a/qQHilCV+wgmO
         HEBJoHGl9DzcJtXs/GNBjxhqIcSvsvL1PO2W9UOnx1xIIElAuKCR11sYuIm8dF7D7zcZ
         rUWe6vxdbtnsgDMdKjLEUrR1WqCTP2WZvQy8+ST5YZKeK0i2kIt3aa0wgONpAanvWmjH
         8I2RskWwUQPlHQnKwKwa6RI9SH/+WJJsQ8lWRLROwjTw2dZuJLTBSbqKeGsRM1XsKWDg
         wqKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ32yemct5zrPI3sRwvOhBOEiSup+2OsDiJJ5K43+OG9602a8CLcPy3CpiQCO5vF848rCPyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNFlK3WMd0bBGZmg40T30poHLfkfY7y2yYcXiSkaBPoIF4jb/v
	TdHbrFG1A41H1bUW5ZhnicQnMQfsq+6oNlvl9C09U0qVVZRnFHr1Cbf6vMncKA==
X-Gm-Gg: ASbGnctocXF0Gpd/yk+JSGKroqCHn2EJotysG4BVQO3qP9h3+4lIzK7zn1XVksJqxXR
	xuqLydVXkaPLSpOp2W9UpBhDKc2agUzNrO80h8HbO63dLpkzoXLZSlB3vT1nac/snT+GX54yin3
	442ZOgC/kagbXetnWcqA7SRQSwEuYC0QeGn//4bzO5cHvfb139H8UD/C2Si9ymr/07CvS9LcdlO
	O9KGvLpaQ9hU+GJyexUBMScZVHdBEkqPWFfYuH3bD8fonjNd2hFdj3GYFktWt3SOJ4S5SA6FvLo
	zD23wjYRidq1adv3rka/5uUrCKJ2edEMQNbSHUpqjNSK1MW8tJyKWwpxAGU3+bg6qMfxyxS/61Y
	7Tae6SjUnl/wE4w==
X-Google-Smtp-Source: AGHT+IEtUlv9kvgBgP7eYpKYGR4YnSpUvaUF+9kRZj5E6VNC8WgtoI9MygU1I0TNPMZvdHODDMYihw==
X-Received: by 2002:a17:902:ec90:b0:223:f479:3860 with SMTP id d9443c01a7336-227f36a8519mr3423315ad.18.1743017768063;
        Wed, 26 Mar 2025 12:36:08 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611bd23sm13043056b3a.96.2025.03.26.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:36:07 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:35:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <Z-RXGsx1hrkfswM-@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-2-praan@google.com>
 <CAE2F3rBo9MM+V6_5aCgQxbK9cfxm1FNnR0etphms7fJ4t3xzOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBo9MM+V6_5aCgQxbK9cfxm1FNnR0etphms7fJ4t3xzOA@mail.gmail.com>

On Tue, Mar 25, 2025 at 09:19:36AM -0700, Daniel Mentz wrote:
> On Tue, Mar 18, 2025 at 5:43 PM Pranjal Shrivastava <praan@google.com> wrote:
> > @@ -4754,6 +4773,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >         /* Check for RMRs and install bypass STEs if any */
> >         arm_smmu_rmr_install_bypass_ste(smmu);
> >
> > +       /* Setup interrupt handlers */
> > +       ret = arm_smmu_setup_irqs(smmu);
> > +       if (ret) {
> > +               dev_err(smmu->dev, "failed to setup irqs\n");
> > +               return ret;
> 
> Do you need
> 
> goto err_free_iopf;
> 
> here instead of return ret?
> 

Yes! Great catch! Thanks!

> > +       }
> > +
> >         /* Reset the device */
> >         ret = arm_smmu_device_reset(smmu);
> >         if (ret)

Thanks,
Praan
