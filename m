Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B4209F53
	for <iommu@lists.linux.dev>; Mon,  2 Dec 2024 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152355; cv=none; b=myvGI9IQtAMGQd2t6pmeuosTqIG7roJnVUMXQ5v+BTsDQ0OLtEEyL+2Pi0P7LO0symotnoiCSAsoi2fZ1NE0Z9+gkKGtIsIpRmBtzzLu5rKkhLnEEcbmMB2vhJsCJobr93KdnnipqjX/A9zojHb/TtyFlejuSypGofBM6ROO2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152355; c=relaxed/simple;
	bh=GsoW9jar33QFlPyu/o1BiPaUWwEOUgAaeEeggWZ8yM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGasTU/mPn3Yd41FANCHSHTrlR/FWd/JYpa7nrSuCgQgIvIF1sd5FmqnrvAlKSexUGHnGLzmXQPlhe1BwyvBQNICjTIviqlrD9ocZY9uYjsK0cxFXntppfKVGYluG/QFyViT4lkOS+cwk8ajgKawZ87vlQURnVHGSmb5RzIxDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eTo2Pa8a; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eTo2Pa8a"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b673aacf13so463010485a.0
        for <iommu@lists.linux.dev>; Mon, 02 Dec 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733152353; x=1733757153; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XySwqa6vfF7/NLOEDfWEU6s1YzlqvfeDKk1Yx5q6yxw=;
        b=eTo2Pa8agh8k2Dp4xgwWGhvd40D2jeOCRHku/FKKlkTNhdHae/kcgLlwiqCqUgY25G
         Fe36N36bOhtyE9gUz+9MOvATa84lUqsH55gBrHgzwRKy94UqWizc0oDmVoz6XmsbXSqA
         Sr0Yth1yjL+S7W6OSwJMV4UPzdZyVLbIDEgT8AU/wK4KtlY92HoBA6Qww1RNLEwy9mkD
         R2d0XSnztCuDKSHZ8JzMQKSn+dQHMbvTyTc83C8mK8FTbcLN3LeCMF0OYnFKRyy6e5zM
         n5Dew+RvuH5wW657AmM9bb2ckoIpjMLJWS2q43RZrRIxX7taHuZGvA+ha2JzZKVwRrHz
         lxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152353; x=1733757153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XySwqa6vfF7/NLOEDfWEU6s1YzlqvfeDKk1Yx5q6yxw=;
        b=m8QBWqL3uLLNeEMKp7NQ/yL0ENUtRL6WFXJ3nl+fXBX4jonNYlUObR2Olg8BBf601S
         bSOzzXDJfh9eBAUSHFgKpwhc7RUDnYYvLIK2bOMczEaid9W8aPLt4g6NNZFGxkhO1K7O
         R/Z7KhybacboMpg7i5HHxAtTSMtz1APSEkvs+s9OgBp5/q/gZM9C2CxDDD/W4ORXSslD
         lsJKu5Ij4mSUsyxkg+EheYidvZaS2I+0ZNwxg4MmN/Tx6QXBPBuoSxp/tjKQZVIcqWrl
         /WFduDY9CsXqmijPIbbFG0DQMP6yiGa8DhQT+PKVkrTAPfZ6sasWUaCggFUY6+VCUSXE
         642A==
X-Forwarded-Encrypted: i=1; AJvYcCXha83DEWp5HgGTQhJDvZC8SsKTZS/xqMyRWrJxw/xjH9vCNc3KiZPkF9ff+Kob0/UTHMGMTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjMu5Y5QVZUpW5ix1CcUQ/XMEyLD+jEBGuD3vdjDERUJoChvtF
	35CD6nOZcrHaS1u5apt9dL4bCIQ3mF4FEZ8ZHZd6KWCyceNcDqqr4+8v7eltd/8=
X-Gm-Gg: ASbGncuXFaeW0U1j4AtqXMVSn4EOgWqCSBmcuEaVoRYqk7RpblK/UDVQlfkXep//xbh
	14IgK6NvDSvXhLyRLmy2qpQR8pMNfH9v1hK46DNpZM45cUtPv7adKmj7K6L+LQBiLDmnP/Ki9vI
	C8rmck8vq+PRjHhkaqd2EklIo88UIZCgWEGkFVx0m9hrKsv2SCF1cE0dGUVInmeIV7m8lILj3FP
	4Bjbbyf/QHifkLRaCag3hsH8VEZ67qF7B/uaTtHL2lt7GZpb2vDUQI19+DmCdDi6vbPinlle1IO
	fOwTwOrMBSst83m9CjzNXgc=
X-Google-Smtp-Source: AGHT+IF2qJsJ0FbtvmhHEABYAPzmLzYktVswQYCd1SC8IwO02PzmD/X8kcsImTR5inQFPXqmLqlW6w==
X-Received: by 2002:a05:620a:3727:b0:7b6:5c7a:52 with SMTP id af79cd13be357-7b6839c563cmr3126058285a.4.1733152353039;
        Mon, 02 Dec 2024 07:12:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b69e94bc88sm79209385a.47.2024.12.02.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:12:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tI86B-00000007EPt-4A1m;
	Mon, 02 Dec 2024 11:12:31 -0400
Date: Mon, 2 Dec 2024 11:12:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>, pr-tracker-bot@kernel.org,
	iommu@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [git pull] IOMMU Updates for Linux v6.13
Message-ID: <20241202151231.GF773835@ziepe.ca>
References: <CAJwJo6bu3vfogmzxpfzFV_guf5GS_1TsqdB29NZoUr-_6fd8pg@mail.gmail.com>
 <CAHk-=wiG+jR7TJdCX_Xa7_dbQP8wU966e8eimUs48VVG9ac0sw@mail.gmail.com>
 <Z0WtI9-Xxr1eY7Av@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0WtI9-Xxr1eY7Av@8bytes.org>

On Tue, Nov 26, 2024 at 12:12:35PM +0100, Joerg Roedel wrote:
> On Mon, Nov 25, 2024 at 06:45:00PM -0800, Linus Torvalds wrote:
> > Those octopus merges may look cool, but you should never use an
> > octopus merge for anything that has any conflicts, because they are
> > hard to get right. Joerg clearly didn't get that one right.
> 
> Yeah, sorry, my bad. This time around there were unusually many
> conflicts between the topic branches, which also forced me to create
> two merge commits to put everything together. In this process I
> overlooked that the iommu_present() definition slipped through.

I know we talked about this before, but I think the topic branches and
octopus merge flow is troublesome. This cycle had lots of all-driver
work and it is a pain working like this.

We rarely seem to toss stuff out, it would be OK to just revert it, or
run a delayed two step promotion like Andrew does.

I especially don't like that this flow recreates the octopus merge
whenever the branches change so there is no stable tree for people to
follow, or to submit patches on top of the current state of the tree.

IMHO the more traditional flow of just merging patches/PR forward on a
single branch works better.

Jason
