Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27A4594E
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154962; cv=none; b=AbUygXVvk1UE0mE8Vpersh3jKoTvxwj9o/oCJua9LzLwwEKb9AS0MQrDAR7sXw+wZhoFV+q3DSvCGolra71fNwX+93GoxjL93xuuZaWeXNTqlm0sfREyQF9oDmmFaU0JxcvKixK9E8Rmr48sIk4o3NnYcBc0FxxUZNgagOZot3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154962; c=relaxed/simple;
	bh=8HE4Ga8BSdBO6M6GmqVFa+HwwrrcZFVY3gTfyQML7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMbA2gd5M8elwy8xSDnl0c0e6YfLR3yMG3fP52xNL/Rj4Eq0uqUNRSMLO4JNy+TTUX2uWpFZq26MvlMOtpUXQH/GzsVTLkXyeRiIo+7DfyuV+706xCPRC23st2++fC6Z5GX+/mr9K+b66Wmf03Qu6uGV8pL0DtXqLw1mz5h042c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SdZnuGZn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SdZnuGZn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42c2998d3a3so5468281cf.3
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707154960; x=1707759760; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8HE4Ga8BSdBO6M6GmqVFa+HwwrrcZFVY3gTfyQML7uA=;
        b=SdZnuGZnYq1nrYDKv1H9kQr2n9JkPsPCTUiqBys/MANaDQTg2N8oNSgb0ITNBsiDdK
         SNYXyAkdf2mYf+QmTJ50pujdaOxBVc21UAaUfrP2ipNp/Akon+KjN34vyhDBbo08PEhl
         +9YpHszvu4A2q2lehG+/qhJPrwlnXbZcBO7VcpVyrtJyfrU8aQCt90gZVFFhXLltMNkb
         737LW9a1eNCf37IuBR1erHl6wVg8lrXu728nB8nLlwRmhbc1Zu0hYJDI3kI9BPYoP//3
         fGJKl53WR/3DSDyTb4Y6i/kurq7UrPjg2E2t0hPl+psYweq4iTdoMex6dL5y62702PNv
         /O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154960; x=1707759760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HE4Ga8BSdBO6M6GmqVFa+HwwrrcZFVY3gTfyQML7uA=;
        b=qqjqecxbi5ziQdwF5BJQLfimvWdCo0Xk9ujeTYZEjkr9JxGCUGXxxJ+AOZ1QhtNTMg
         nmSdoc0Ar/1BLbeOU/1MnjdfmzR8VzNUH+BNJVLxA3GvaUqcG4N/EEieMBEzWtGNHKxS
         uMOGhGsJQlUwH0H8K9i28WIezHvJC36alSGxVcqzWYEprtZhvB7Zfm+7DpFz+0K8Cv3J
         H68GMxqlsruzcwcgRdMNxBu5joVZtkaDQEVEKfQch0+irdoC/RNaCFrrVkqJLpqdUIp5
         GN8GMpyVuCxb+gWqYo5PfTVYFHaTF7Bv+mG0CsTJhcMI01htug8UnagjPteMfvdzlUqP
         aM2g==
X-Gm-Message-State: AOJu0YzkPw0JY/aWdunuq0pjHjM/nk1xkH248vVVYN7jVtTKeMNR9Iqq
	hCIvudfAXkCjjs7VMh3b9Zt1W1JsmNvsN+G+emSiD5TqH7qKgWPAHMsBFLiN96Y=
X-Google-Smtp-Source: AGHT+IHU4KsrD3c0EP9g7y8hIFpyaAa4okXRRNN8qBm5KuQa3mySXXt7+dYoSw0Wr4a8G0dHjecPyQ==
X-Received: by 2002:a05:622a:60c:b0:42a:9cd0:10d6 with SMTP id z12-20020a05622a060c00b0042a9cd010d6mr76578qta.34.1707154959703;
        Mon, 05 Feb 2024 09:42:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUJEoYPtNarb3IKpx+TlDaQWnlGCPYYwqRse61FZumUi17YhNjF1PV/xF22JLrvNXqFbkebE3MWbOPPsd6X9lkUYDUu8OcgOJYYw525y7FBiRK5b6k1ygrBSUjRHKinQ83+/bgI+lNtpfQIgMjD96anUt1JUN/A07pGruYvZXzU+IkWkDlqulHlYWtlENVhDo7EDFB9txF76qn+sovVDt+EhL7ut1S/hZswfg+VWs1j/g37rEX6ap6/4HYUNOLco77wrroLxU0HPFDsjm75+gckY78bO+VGj8ZjeEVOo3As9m48+X0kxJ0Q+DCxEkK31OMS3+rk9JgZYfc/rvBZ4DfknXCKEFbNUSYiTsiRn8LuNk6aoyUi8Yt0fkyR8E0kWWgCK3tQyQl37yuAXLLWMzwjLPdLL+LetoDhwayckEgT6hVcQTSAdr/64XA4acyBFh/KrJTmXe27EODPpZ7XhFeqlSK9tOkNG5gDuy05MIpWcUZfCBG5xHxACRXuyekJg91XbC9JxH2AkXUiOdSYdpHdIXrVkRrLeiPD0hPJPc/vsi8qojAJdzmxkzyfLzLhg19sg4M2WCCcphSLrPd+8rW3G5XCnkab07S61wEP7FLkMnOakYoKQoDGJkTOFQdDEWmESvGbq6OoQFA0uUJj+KlWqrYt9e4aDsPJbchaYnyqj5Tje8QC1runF4T0tAZjue/v+GvEzghpVJQWjy+T/0qjRPKiwuFVw3YGWf5PAbhZzViL
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z5-20020ac86b85000000b0042c04cef1d6sm137895qts.66.2024.02.05.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:42:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2zO-000fQ2-NV;
	Mon, 05 Feb 2024 13:42:38 -0400
Date: Mon, 5 Feb 2024 13:42:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240205174238.GC31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:45PM +0000, James Gowans wrote:

> The main aspect we’re looking for feedback/opinions on here is the concept of
> putting all persistent state in a single filesystem: combining guest RAM and
> IOMMU pgtables in one store. Also, the question of a hard separation between
> persistent memory and ephemeral memory, compared to allowing arbitrary pages to
> be persisted. Pkernfs does it via a hard separation defined at boot time, other
> approaches could make the carving out of persistent pages dynamic.

I think if you are going to attempt something like this then the end
result must bring things back to having the same data structures fully
restored.

It is fine that the pkernfs holds some persistant memory that
guarentees the IOMMU can remain programmed and the VM pages can become
fixed across the kexec

But once the VMM starts to restore it self we need to get back to the
original configuration:
 - A mmap that points to the VM's physical pages
 - An iommufd IOAS that points to the above mmap
 - An iommufd HWPT that represents that same mapping
 - An iommu_domain programmed into HW that the HWPT

Ie you can't just reboot and leave the IOMMU hanging out in some
undefined land - especially in latest kernels!

For vt-d you need to retain the entire root table and all the required
context entries too, The restarting iommu needs to understand that it
has to "restore" a temporary iommu_domain from the pkernfs.

You can later reconstitute a proper iommu_domain from the VMM and
atomic switch.

So, I'm surprised to see this approach where things just live forever
in the kernfs, I don't see how "restore" is going to work very well
like this.

I would think that a save/restore mentalitity would make more
sense. For instance you could make a special iommu_domain that is fixed
and lives in the pkernfs. The operation would be to copy from the live
iommu_domain to the fixed one and then replace the iommu HW to the
fixed one.

In the post-kexec world the iommu would recreate that special domain
and point the iommu at it. (copying the root and context descriptions
out of the pkernfs). Then somehow that would get into iommufd and VFIO
so that it could take over that special mapping during its startup.

Then you'd build the normal operating ioas and hwpt (with all the
right page refcounts/etc) then switch to it and free the pkernfs
memory.

It seems alot less invasive to me. The special case is clearly a
special case and doesn't mess up the normal operation of the drivers.

It becomes more like kdump where the iommu driver is running in a
fairly normal mode, just with some stuff copied from the prior kernel.

Your text spent alot of time talking about the design of how the pages
persist, which is interesting, but it seems like only a small part of
the problem. Actually using that mechanism in a sane way and cover all
the functional issues in the HW drivers is going to be really
challenging.

> * Needing to drive and re-hydrate the IOMMU page tables by defining an IOMMU file.
> Really we should move the abstraction one level up and make the whole VFIO
> container persistent via a pkernfs file. That way you’d "just" re-open the VFIO
> container file and all of the DMA mappings inside VFIO would already be set up.

I doubt this.. It probably needs to be much finer grained actually,
otherwise you are going to be serializing everything. Somehow I think
you are better to serialize a minimum and try to reconstruct
everything else in userspace. Like conserving iommufd IDs would be a
huge PITA.

There are also going to be lots of security questions here, like we
can't just let userspace feed in any garbage and violate vfio and
iommu invariants.

Jason
