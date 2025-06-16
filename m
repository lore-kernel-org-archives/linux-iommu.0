Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451C209F38
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084811; cv=none; b=ALz8kXfCGju4p36E9sTHOya/f9q5dUbI405/5HBcLkhrZWl5bvaPg0iZ6vnPJ0/c4a4GiMU/Do5SZzNPsk/KzqYABcnZyp5irKmoDjPs32bNncTw+DsDNltbm047wPi+QHCdb1TEo9XBCkwtMcmj/sA8/F0cxa+U2oZERJ3zv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084811; c=relaxed/simple;
	bh=alzKuO2HUZuN6seuaNV/GeBPt3IdXkXqoEGQP9n+sUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB4KOvdDcYSZEbi5NLWWmmG+wOD1Vr5wD5t4XC4pdKwfuKItkwbowiiXWJYdySu3GDawSAD/7/4ZSMMCQ48QmtyQmtUBFZtuu/aRFdqMIl+44fnYOfDM4/Vh9CZFZRoVTHcAyc5OPev86HIywhz3Nx6ZxwHYHrAdr9xvCyVMprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayOg+qg6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayOg+qg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750084808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Bss5qqcnQ+vggz3TvV/UxUdbe6K9A1vrlez2JEJ/Vs=;
	b=ayOg+qg6LUIl1M3vdPeVVm97d91c05Y+ipWMz+0L9lmn1bNnCZTZhO7mcFi5MnThRcyGYt
	h44sso1syhxQfxbzXJKCtpOeu0iCdMK1ftyUO60V0kTPoKyeoVPyEjfRIDbIkGzklUVIw8
	TBGQD1V12nVr0t+y33QUM+3gicRefyg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-wjR80vWYPXmsAUe3J661eg-1; Mon, 16 Jun 2025 10:40:07 -0400
X-MC-Unique: wjR80vWYPXmsAUe3J661eg-1
X-Mimecast-MFC-AGG-ID: wjR80vWYPXmsAUe3J661eg_1750084806
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddd689c2b8so5837685ab.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 07:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084806; x=1750689606;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Bss5qqcnQ+vggz3TvV/UxUdbe6K9A1vrlez2JEJ/Vs=;
        b=krqOODcPRXJJHTbdn0IEVNW3Tlorf1+a1+BpDPzfkGKVll4bIwEgHR0V6pVPFdJNP9
         Z7/NCW00VqmOE4NYvKzfhuSCuKk/bLu7b4TvO84goeZtfFLCXNdvFoYIJWm+Ru39s6uh
         jfQ1TPK6/rQwrXne8JoyzPB8JRRYR9JGfkP/5ByvRTpZcNikkWHelxypISNt8s0r1MYs
         n+CowfYQFlaLTqeek0rDw+31lC1zmCnIrlXQz4AHUWPRLHtb1yvWA9/2KRU1ytzzmySu
         /zfyo3otyxKjZFjtlKxe5yqTbHnoLJL+bPKA2MygWwlxhHT4QQ7T+eEsmGu7BWEYB1Mt
         kvDg==
X-Forwarded-Encrypted: i=1; AJvYcCWq6CklcY2BJ1q3l3EuYyjJ5h6xW1unTmDJUYpXCdk4Z7aKrOjaBOIDh92B0ygtUlx3mX5jFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzqa6NgFJR5Yx7Pegr/yAsR+I/u9gw7ZysbeTfaEnY7zKGUxLW
	MCk/XcNYIR3I8GlMJMx9sHQ+Ng0dpHkiHSF6Q3/fGjA/OXmFo7fmZgEV3zY0C7MMj9kEp0xgjIK
	dBlGmqE7EJhcc6PDL2kIuVRzZKWDezNkDac6ZwjxPmP2NVm0HDOLmB82L
X-Gm-Gg: ASbGncs4jFF8GAira1KOyD3ueOZiLQqxzwVvU7RiQP2WuWbcs2FJzsjap45msQnHFro
	A3Eq42ea4oNIVwqYOu91+xY//MTLtW8zm1NE/qXkffddVaJ86ISGZQ/6RLUF/Am+icm4XVeUoaK
	mG0rVjRt5dfPqNvAB8kEENZ6BhnNSSWNVXdzNJhFbY9EmIVfSqQCGuvL4+YJr7GRoTs5QoxhE8c
	HEEmkYDB7TghVdkDqGmWWgPwTyGc7Z37BWz0YWodTj4mJk0fLhTTkIi01quqXS8jCdZdjtP1Oh2
	VnvsR9jknDPTD6igVI4qQCZ8qQ==
X-Received: by 2002:a05:6e02:2281:b0:3dc:8bd3:3ce7 with SMTP id e9e14a558f8ab-3de07bb709bmr28632785ab.0.1750084806583;
        Mon, 16 Jun 2025 07:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt1gC/tTVDA6OKTBkfq8GQVqnf41DPJ6Is0kTyewN3p0cyrsdoZpdhJscEgKPjTA3hTiFNHw==
X-Received: by 2002:a05:6e02:2281:b0:3dc:8bd3:3ce7 with SMTP id e9e14a558f8ab-3de07bb709bmr28632665ab.0.1750084806159;
        Mon, 16 Jun 2025 07:40:06 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de01a4544asm20077625ab.40.2025.06.16.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:40:04 -0700 (PDT)
Date: Mon, 16 Jun 2025 08:40:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] vfio: Prevent open_count decrement to negative
Message-ID: <20250616084001.20ed53aa.alex.williamson@redhat.com>
In-Reply-To: <20250614000926.GQ1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
	<20250613163100.7efa6528.alex.williamson@redhat.com>
	<20250614000926.GQ1174925@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fY-qVXaIb_yDVwq1RylASsr0vzfR6Mre1y7SuLj1d6s_1750084806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 21:09:26 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 13, 2025 at 04:31:00PM -0600, Alex Williamson wrote:
> > Hi Jacob,
> > 
> > On Tue,  3 Jun 2025 08:23:42 -0700
> > Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> >   
> > > When vfio_df_close() is called with open_count=0, it triggers a warning in
> > > vfio_assert_device_open() but still decrements open_count to -1. This
> > > allows a subsequent open to incorrectly pass the open_count == 0 check,
> > > leading to unintended behavior, such as setting df->access_granted = true.
> > > 
> > > For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
> > > (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> > > results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the
> > > first run, but the second run succeeds incorrectly.
> > > 
> > > Add checks to avoid decrementing open_count below zero.  
> > 
> > The example above suggests to me that this is a means by which we could
> > see this, but in reality it seems it is the only means by which we can
> > create this scenario, right?  
> 
> I understood this as an assertion hit because of the bug fixed in
> patch 2 and thus the missed assertion error handling flow was noticed.
> 
> Obviously the assertion should never happen, but if it does we should
> try to recover better than we currently do.

Certainly.  My statement is trying to determine the scope of the issue
from a stable perspective.  Maybe I'm interpreting "[f]or example" too
broadly, but I think this is unreachable outside of the specific
described scenario, ie. using iommufd in compatibility mode with
no-iommu.  Further, it only became reachable with 6086efe73498.

In any case, it fixes something and we should attribute that something,
whether it's 6086efe73498 or we want to reach back to when the assert
was introduced and claim it should have had a return even if it was
unreachable.

It seems these patches should also be re-ordered if not rolled into
one.  Fixing the issue in 2/ makes this once again unreachable, so I
don't mind it coming along as a "also handle this error case better."
This alone doesn't really do much.  Thanks,

Alex

