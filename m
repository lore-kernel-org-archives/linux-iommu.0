Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858549;
	b=5B6Sy4K6aKoUbJCRR1gP+wPx1RxMuCQpjpKWh0TsnEzHPp44MX6BaXlZo9be0KxXEjrB
	 4rcs90yxXi7yF7ZuZV30GMlJxGFRIO4oVhVFCqq66Om/O94ST8eq0xo0w4qT8OrRvbuch
	 qURj/GMdxQK7pY//lse5Dn/jvyRVz3DwMH2kJ0xn3ZaJQl+ZIL8yiUKqt6pAD03ZTTW4u
	 DysqqBMPd1JyLmrDmQ9SMptseFZxpprZa8wct9CcTVocgllK+G0dI50kVwApqu3KLM+hU
	 0EymYgHSchpICevSMoQKd8fWt4tgxbRbU/1dFUe3lCGsyQEOqp+jqJzysXJwuj+ga+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
	b=Q3DwqPlnzrDPIc6Z+xC78HQBGSoDRqrlWn25t554FLb2Lr70bBSy9mr8kvmqDv3WALQg
	 PtuH0fByEA6167uBjqoRTfjbs6e70jzV5Q4rIptm8yFmqmB4mnBn4Bv7vZ1Ec8eipGMsn
	 Z9/CW910RW2g1tDQfK6F/RamlCK4quALs4ejHrn24ziUXu5sMKMRe3lsMEn0+puo3QrXB
	 7OYqbf/f8HXYCK66fEF5ZCk7TN9d9EZkukyvNuXXDXwmvVKLZDxU+uPST9SYx25loD06E
	 BRz0DKUujEJansAxifRxQuR7GYgYCalBu7xC7zJzX9StO7Te4vwhVBFGD8jpcSzlewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BCh0Ge+g;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D1606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 522D1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=BCh0Ge+g
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91e7fc8265aso57234826d6.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858548; x=1795463348; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
        b=BCh0Ge+gnP1w31jfGnGKKknObScNYBAzzV4Qmg0EJRx7EvNWEN51CHfTqGFzfONJ/N
         rxe2TmMsgIyr4PqsycIqVCHh5cIkRHX2UhkaBY3NwyUONb4x5q4KaZiAMx94pfxYAExY
         fVf7cyjAP1PMBnLoHydNu71Jp/TO3iCchfwhJlae2Tw944Np9S02t1U2WfmWB0jkepOH
         mqTHmQV7vlIe9GZZP0FK/lD9UHV3FkE66lgudKRbjfXTdS5P7f4VyaKIzsiTYVNZs0pB
         16cq8+5qCLgyB8XypQyctV3UkJbTzSn7t+J32QIOWr7vZpQKFbgl22U3IF2tGmomEoV9
         Wthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858548; x=1795463348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYgfM3NjhEFUFn9lrkoVqv9gAjE144oaGhmBbKw0DZU=;
        b=JoZXoWcasDCFDEdvmW6l9E3uMj09GXlEZftd4sW3VYaNhWuCL5tJFfoFDLV9cmNall
         hgFR21V7TK5E4eGukcWd9IXts7/nmE3t+gkCpJMdTmnsMIO8PvOwTRVSDQhDfqDH00av
         YbMLmd9YnHgo9TsPdBEVuN/qC2/Sww7kQr3QTYoGe6kleZ+x6AediS+dIoilbptZow6l
         6y+v3jP7lRo9kr+wd4rGAVhfYcivtl4UEo5+qoUiQCJb3iDpnyBOoQ2veZnPVx9rvrPY
         Vt2ay17+r+Q2YL459sttjWkfN62Dn3ALI5dg5fRQn3Kb3h4MSvn16ptq061pXBR73yFP
         C4/Q==
X-Forwarded-Encrypted: i=1; AL+hErFOMWnpJ37tUaTRFYzNgEBNfyxfjvwMTpvNDdIXXqUiHiJ1grmHFfmzKxKy4obY1JeP8CflFQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8xtR6CyAmqf+VX7N2ZAMMedeczLPVTHJWHm6sHp/m6iyfv5lAw
	JJ/+pPLfAQsvuGIpOgmmkeNtIEZv+R2vsl6NlSD0KsTitf8fatAAvGXCV5jRf6NTxwo=
X-Gm-Gg: AZFdTZc1VyYbeffjIv7qMxWgUErnCgmnJFmlkPlS99GccS+mOlw8IthElwTaXun4qGg
	RAxQlrs6P2OI8+l+0MxdDlpIGH2+EbRQt8m90aEsNfAlVnj/+LviT16nhIpPBoYD7sUZQwBpwFD
	UK0fiBoJdoCxPWbCdRJQo2nRZzaCYNLhZQ1X+MfYRFoBCWlFH3nINGgyO7BY9y5cvna+OWaDckR
	clmST2kv3RN8KOFuWZD0q/zGTBULOkzdU4gPgYE3SOpdkAoTUNoFzNGG9+vQVhBPjdUqaCRSYNH
	5a6R0v2hybe5x8lHldBmP+dc7zCuO3LNVUJCv0ennSg07lOW04/5NOlQ2OdA2bITIGaCILaCNVN
	zRFd38kWVOqSKjwnkQBBl395Eigq9Tjqqq+/m2SiqRKt86gyAX53jcRTgWVLoQTg47r5b40sYxF
	7pK5RaMOCJveyH41nJ4Dz7PpEFgLWjaGXALleT3CB4RKCrGD/PhI/5i/AIQ9yVAhp9h5OICiZMt
	ffM4ET6cVd2JQSFA+1fnl0tYfDmoPI3ksdGVYkhDjW2wZeGjJf3CAKiqwupI49Nla41AW7WqbW2
	CX0yew==
X-Received: by 2002:a05:6214:2346:b0:91e:a519:270c with SMTP id 6a1803df08f44-91f241e0c23mr182367506d6.13.1794858548269;
        Mon, 16 Nov 2026 11:49:08 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23da6adfsm91844916d6.36.2026.11.16.11.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:49:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2hO-0000000ALLf-3aft;
	Mon, 16 Nov 2026 15:49:06 -0400
Date: Mon, 16 Nov 2026 15:49:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <superm1@kernel.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <20261116194906.GE2452510@ziepe.ca>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <44ac3423-0a51-4562-816a-fea881511afa@huawei.com>
 <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a444421f-178b-49be-98b7-d34dfb147604@kernel.org>

On Thu, Nov 12, 2026 at 01:27:50PM -0600, Mario Limonciello wrote:

> The problem I see is that in today's day it's incredibly easy to hotplug an
> external PCIe device and not "realize" that it's malicious.  For example if
> I leave a dock on my desk and someone inserts malware into it
> I might think it's perfectly fine.

That has nothing to do with lockdown.

We already have indication if a PCIe channel is external and
pluggable. If you want to demand that such channels have non-identity
translation that seems like a reasonable thing, but nothing like this
is handled by LSM today. Nor do I know how you could opt into such a
mode without causing regressions..

> The current mitigation that exists is that in the Linux ecosystem we don't
> turn on PCIe tunneling "automatically" unless the IOMMU is active.
> 
> Nominally this happens by way of 'bolt' userspace writing a sysfs file after
> it confirmed IOMMU was enabled both pre-boot and by the kernel.

Yes, and we are working to generalize this kind of flow to all of PCI
not just thunderbolt.
 
> How would you feel about at least blocking the user from turning off IOMMU
> (if it's present on the system) via the kernel command line while lockdown
> was enabled?

If you wanted a mode that forced protective iommu translations for
everything always that could be reasonable, but I don't see how it can
have anything to do with lockdown without creating regressions.

Jason
