Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3428D8ED
	for <iommu@lists.linux.dev>; Fri,  1 Aug 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074774; cv=none; b=k6zwi5EuMvrs786DK2Y8BhXHRxYlB6mI4hdMo0wNPw7oDDKNmeH5mQUbwqIas0q4iHMWT11iBQqOfXvmHsHW4m4rFa+IBv1MUtoVXqpnaYiWNK8PinPvP1MMlgrAKaMAua69BtwuoJJkezzFnI9fCPk5jFM8FogbYNlXE1yEH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074774; c=relaxed/simple;
	bh=ZCus/7TYCpdBpSHkNX8J3JFdhNbHBG34XLdpJYdbpIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKkpGCp/ZTDHqmDABFOyXIvUcWPU5OoGpRIwTSpDXqZujqMFybltHyr11jpmb+IbSmPDItOg6m000LzEnD3v3MbXnjYq4L6xeO/Xjjf2YwqIPJ0gK+A2Z0V6LjGgcr6fFlfzUlva+E+09OtzVdYTr6b818tCB0DyOFeTtjh9osM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WBn0PiQg; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WBn0PiQg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aeb2edce3dso10816481cf.2
        for <iommu@lists.linux.dev>; Fri, 01 Aug 2025 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754074772; x=1754679572; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyIY9+7qRYH18QG3yHqvpWY8fQNePxyU0Y1cLmmOWtc=;
        b=WBn0PiQgZniBXhNPZqC8wShHxgEgzYqWEbDyCsO0Z7dT1zIJF6UEeUzzvHByHqxMSd
         Bh9gi2gbBO07hYEJn0WqPCkZBaiA6yhQL+5XXaYXqPISOhKQynondEM/S8+AnQNwf5GG
         T6Ou8cjsvlfF4dSRLFFEzqBPxkVCcGWzrEtuhOqt5yDCua+02h0XIAxhcE0A7BqqXgeS
         Xo5UTXKtJaX9SuyIIKnJ580QASlpQqdAGIj3bugUYb4DZIrCgOxUO66g01MOTP+uGMKh
         EZ2byuVaEkv5iwofKIA4UFdCsz1C+6FB/54aK+qhDw7DLS75T6nugtAVq8pqBFgxDO2N
         Knsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074772; x=1754679572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyIY9+7qRYH18QG3yHqvpWY8fQNePxyU0Y1cLmmOWtc=;
        b=hgLlOXcExhUy3hlIjEk2K6IqGZawPnRz10IRs/q2OyxOxMzImIul3AhWHvcUoTcMzq
         vxpj/9jqNMEfTco7ChWBJoVX1CKck7XUbGkR95VVvUeCFCE+UUgNMbrZsUxnaXgDifLz
         sgYYwe56fCD8u5L8y4PMQqh7utFCbAO84/MYujjAmxAXRj1VlocDB1+/JBLBwgdYHxDT
         GFLAUe4Y9753DTOJD438kd8seYmhxaRoWyUIMr8oa11yl51xKxX1xT+fEyY9WQM4kU4q
         wyQJNMCadv2QkDYNSgn5wqrTxYugOxfR1iiWCxT4hwDXLUSsZcjdFOg3EB/T35iODsWC
         u8OA==
X-Forwarded-Encrypted: i=1; AJvYcCWWgLZsL3r2Pgf9w3V+bL9dJ/lMBUElkitcO6B/TKf22yDpzMiOCnADvCJDUbtEPVmlqrlVWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz9o5cNCYzOfpn3XBVD9ax/WWJiU9vof+RSYetWhxDlsumYTYZ
	JLSGnUg3rCN+FLbHxHgb8VQnS6Ih2yWMuB8ugmL4g6EGKTys8J0UUftwFEwAiP9l2Ho=
X-Gm-Gg: ASbGnctoxVfPcX8Uftpr2toe+EQ/P/k3A7L7YfBzJsEPdLun8kuf+VSpmC/qOyWwiPX
	BchPclvGMbgZjfj3pjF44smfXvG7mnTj695ewtEYo9bJUdsMTgdMQTKHwwl9VpSyMbVNojkxHnw
	aMGvK2xMIL0qGvdWwe+P7ig1k+5zkqPctL00dd8KOn73nx/AZxEYqsB53dKfAFpVpyFcdb36juT
	yrmY9/t//MV2IYBDn1BY6tfvtQFL/0gMiReNREt+2eRxj9//JgAdvcdQvqndES/kKt1o5+/gQ7i
	9QD8wV16qJGgf5yNUszTrM8O536XyxL3C6yKmWxtm1o8MV60szVlTT/oB/UkfKzNaSfdvfdu2fW
	pBQb3CoittKWQi8DNpYG80n5FlB5T4YdMooT1Dx/c3LvPzj6NJAXOUQUupvEyRHZ68awp
X-Google-Smtp-Source: AGHT+IHvW1P/vYfLuQdieKRLav2sj0iL8HcBFcWOObvqQ/GoW+Jjhx1hxhp1NE0qHlpxeA4ab2Hb6w==
X-Received: by 2002:a05:622a:15c2:b0:4ab:887c:8b with SMTP id d75a77b69052e-4af10a88ee3mr13217181cf.42.1754074771752;
        Fri, 01 Aug 2025 11:59:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed670c6sm24010891cf.37.2025.08.01.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:59:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhuyY-000000014Fy-2vCk;
	Fri, 01 Aug 2025 15:59:30 -0300
Date: Fri, 1 Aug 2025 15:59:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250801185930.GH26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIurlx5QzEtjpFLd@google.com>

On Thu, Jul 31, 2025 at 05:44:55PM +0000, Mostafa Saleh wrote:
> > > They are not random, as part of this series the SMMUv3 driver is split
> > > where some of the code goes to “arm-smmu-v3-common.c” which is used by
> > > both drivers, this reduces a lot of duplication.
> > 
> > I find it very confusing.
> > 
> > It made sense to factor some of the code out so that pKVM can have
> > it's own smmv3 HW driver, sure.
> > 
> > But I don't understand why a paravirtualized iommu driver for pKVM has
> > any relation to smmuv3. Shouldn't it just be calling some hypercalls
> > to set IDENTITY/BLOCKING?
> 
> Well it’s not really “paravirtualized” as virtio-iommu, this is an SMMUv3
> driver (it uses the same binding a the smmu-v3)

> It re-use the same probe code, fw/hw parsing and so on (inside the kernel),
> also re-use the same structs to make that possible. 

I think this is not quite true, I think you have some part of the smmu driver
bootstrap the pkvm protected driver.

But then the pkvm takes over all the registers and the command queue.

Are you saying the event queue is left behind for the kernel? How does
that work if it doesn't have access to the registers?

So what is left of the actual *iommu subsystem* driver is just some
pkvm hypercalls?

It seems more sensible to me to have a pkvm HW driver for SMMUv3 that
is split between pkvm and kernel, that operates the HW - but is NOT an
iommu subsystem driver

Then an iommu subsystem driver that does the hypercalls, that is NOT
connected to SMMUv3 at all.

In other words you have two cleanly seperate concerns here, an "pkvm
iommu subsystem" that lets pkvm control iommu HW - and the current
"iommu subsystem" that lets the kernel control iommu HW. The same
driver should not register to both.

> As mentioned in the cover letter, we can also still build nesting on top of
> this driver, and I plan to post an RFC for that, once this one is sorted.

I would expect nesting to present an actual paravirtualized SMMUv3
though, with a proper normal SMMUv3 IOMMU subystem driver. This is how
ARM architecture is built to work, why mess it up?

So my advice above seems cleaner, you have the pkvm iommu HW driver
that turns around and presents a completely normal SMMUv3 HW API which
is bound by the ordinately SMMUv3 iommu subsystem driver.

Jason
