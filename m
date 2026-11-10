Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316621;
	b=XHt/8Sugt5lMsWy9hQoCdJKOwpAB0he4yfolrDBl8GabAHiE5xde2Br7LG02isuqzOwN
	 G4LKyZAQxJGhev+hzeKv9dxvE+9lSugkqBZyYUnKg/h43QRwWYjQqa6TcxkBcgjxTfEx3
	 BAAumx36dIJt33MWKXwSaEEYULovp6M8NM8u0T+26ku3Ztd2cbQyONBL15U60MGxGeKJR
	 U1+8NEQui+g3OND+kKcP4pw3NcSYgJAAG+mQ6b0u4bj/GeBUcgmyUMH7EgaKRIG04jHnw
	 uUo2oaTYhNebOWxFeQBdBZDrSKwBAmExuAp0iA8kLFkS6bj5mygmWj+ePP9M6ew1u9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
	b=wRO90S9IQl/TtA770e1bZ3D5F8uy3hAG7R5+KIv/DbGsn4k3UHjczi85PsCfzr3r5BWi
	 xatlF5gYbUgr4vVEHQpMDnhnsVBILuCGIVi4Uyr5RF4+cWE0RXrhU1mrdHLhA35Ikkxds
	 BrCG43pXK6O0cVP2Zp98v0UwBzccngIZgsm4yr3zzRQYItlceHP3k1xmW5GotxctMtvaf
	 y6weXBQY50A94v1UO7H/u6pXchmO9+eKnBWZ8yPVidK9kkyEjndZTY9/Tr0tDUfgvHX6D
	 gqhGv7MXb7iOHqv7ymjHhWgePmtgDrWJg7qzNTFS3I9jdOBOq031T0NbmTWKo9YPv0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ZXG6BNyq;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F63606A7E8
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F63606A7E8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ZXG6BNyq
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e6eb77f0bso174578685a.3
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316620; x=1794921420; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
        b=ZXG6BNyqiA/cUq440MADmjUgxc73A8mtwJQ+riJOjjAcxCEKAHfMctz2qSG0eZ08Ec
         ScZI9Kzf16NN2ap6v5NXu9/+UfzmKqOBGI584ZAfxentJMDIKEycbV//YQjeZ/EJEagh
         2oeDJukIOHQZbLslPTG8vT5Umx6VFFCHg6QbgbcQoc8MMlAl3VPtUUk9CL8AR5YisT9S
         Dsrowpd+4dqUwjjWipFSjWwpNsm1bZ/ArytREkCYqMUcW5KYfTdL6FoDs0WD0ueJk+qJ
         dzBS9CmKxnQvafRojIMpnPyvBdVmUnJSEbuntN69dUw8ksqFHND826Siu0j53ojKjOe/
         oY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316620; x=1794921420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
        b=JHsjFvDoA7TFlXyqcqIBHhjwBu9ytpGq+kw3q2Y1ZssBvXMmC6/DkRMdKKgcE0V27o
         gt4qqY9A/u0VJmKeEkMJwRJiD5AOePvSncJZeZ+e0Dn6xqai0Smp/f52V1tb1nz/QlrY
         fgg+8k21f3L8q5SLhpmNIgI1qN+pM8XWTCTEa2cuyhCfZ9MHc+Ku75/pc1z55EGRfBl7
         PuZRxtN44QFpo6O6drbKMLfJxmfcUKqV7OAUy+762KxHozjz5BGOIN+lhJxgbuBpZe9k
         2olZRBW5RZP6YwHNuavVxKHYvDLldNLVyvXvCgqLmDwYZt6JEjj1+Iy4B5WF2vNYgwOc
         M2Ow==
X-Forwarded-Encrypted: i=1; AL+hErGQ9oBcX1GiHOXK238/Agm/QFZudN0i5ZBl2jCUqYeY57mf8q2392X8ih8o4ZShNEVSNmp02w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8hHZ/3z77W76QJs+SVoFpy9kLA1AzIpgXnDhqmJNq2VJkp7X4m
	To/y09/KfAjqZ3/OKgmBKK0s6L2Th6i/zyefhOr/UXA6Ze1GS4cnit7t+V1tLRbaPbg=
X-Gm-Gg: AYBFou0oy4ZByMHtQuorVnb9JlzQTBR74cZXAI2iJWaG7Je6F3vE7qgr1AwqCF04a8w
	kSWHxnviR2YSkzYhPtkw7eir2n/GuW0wENmjBlG7DTtYqYNbbmuB86hyjaYfw/8pEqvQUHREZhS
	1S6msl6VAHKTP/oIsStGKDGoMdCyfFlhu/T/A5qJFjV661bu0fU9zVl+9aMEP0oIYfnBHhxBu43
	CsA/u6hwBQgS1wlnSrckUf5vE/6pv46plrw0IFezPzeYh8y0/awTvOk/vHVC/W0VuiEU7/jc3gR
	unA5DzPVm/00R28meqnEs9zTBDXrV5giU2gKfAXCcrkmLXLrl0RbvJRppYQJHYLydqv1qQyuD8G
	bjgikQ/cGfxnEWX47JyWdBorlv7vDD6ynVPROvdpm02OBtzgr8VdOJXg5+9Ly3rFuKlpeevZp0Q
	YtXzVMVfQw5PN28yqDQmkfRkvvjmuKFcVRf+4t2gYeuzwYAbbsz9CCv6gzgTVq1vjA9wFFO53xb
	xYH+g8duVZ5WAUtEok8SQ2R2TgtHw1Ie9PxOtpDd0RNMQxy/o9i/EEcYx7MKbc+WeyXcfC6pW1G
	OrkU2vc9TtJ0XwVvka0Az8U0/4NCOvVNveoah7saM/rN1osQEPwM1oqwM1iIl047rXfPl2sIezJ
	fRe9GijbMFNg=
X-Received: by 2002:a05:620a:1724:b0:942:e4f7:6104 with SMTP id af79cd13be357-9479f3766f2mr439618585a.55.1794316619773;
        Tue, 10 Nov 2026 05:16:59 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61c333sm220869985a.3.2026.11.10.05.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:16:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQlic-00000005geL-2PDT;
	Tue, 10 Nov 2026 09:16:58 -0400
Date: Tue, 10 Nov 2026 09:16:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: tanchi25@mails.ucas.ac.cn, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Message-ID: <20261110131658.GW663069@ziepe.ca>
References: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
 <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
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
In-Reply-To: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>

On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:

>   2. Use the guest PSCID directly, but allocate a separate host GSCID for
>      each vIOMMU.

This is the right model. The viommu should allocate the GSCID directly
and keep it for the lifetime of the VM.

>   3. Share the GSCID and maintain a per-vIOMMU mapping from each guest
>      PSCID to a host-allocated PSCID.

AMD is doing this because they don't have something like a GSCID.

Jason
