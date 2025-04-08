Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759823E351
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145496; cv=none; b=anZNKMyakyI0HxJpZ0VIRMX/WvBm4rfQUauECkxwrsuleqKpK0gWbQYAutLrjzlXp/g9iaANi1jLp3gp+/JsuZ+W721ZlM6Gva2jb0rotftgeGjXDZh0qNtvjGaPiW/u2/NGdO0xmzdOzIXlbMGUii3saL8CmHV8sxdJ6szpHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145496; c=relaxed/simple;
	bh=OMfNblk7e1bqcX5flCxsW4kUHjTHdM3NGhtOUfpBXUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Icy/QFbCRHtXb9uq67qoO6o3AH6TyCzYAwyxz/cwSKKmJ9DhugMcHJkxg5mVW2cVoZ7tOYAbFn7RJRjQuQS8kit2cj/9YdhzZ2YWOHdtOWimJFLZ0Gp00oxp7mNMM4mmkBmW6gMLoXR51UZvNjrFqVWusRx3YD6IOmDqXaQxA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xswrqf9i; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xswrqf9i"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af51d92201fso6659842a12.0
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744145494; x=1744750294; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTcE6+WHWu4qnclYQMHYIxEySZ/v7P1Al1jdu/317JQ=;
        b=xswrqf9iAHYPbmnH6z6KD0Cqyhpm31a7AQKXmBWoK/Q6xR6NrfdmKust6kuV9K0hwQ
         U/OT5PTpnOCA1PIHOdU6oEZ3TwKXwl7oGw5aWqfUU8ZBEMX6HlKFLk3mtcFDHnXU1pff
         RwWVx8758BueWM6pDCx/Rh/5Wu5OgY1HvLsVxg0RH4weoVgBhWqV6q3aDXJx6BZqdiU5
         5MH75ZLPal4D5NBu8BMFLakMMZnKpOZIg4BEsm2CAncfSix10R+6LP5jCkDDIb5rhRuS
         wLWtcox8gepdRIH+PVWcDP0gMEPpyxcJB287FBS8UOz/wTzxKCrMTBJ0BfZ8W6NtlWJn
         VPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145494; x=1744750294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTcE6+WHWu4qnclYQMHYIxEySZ/v7P1Al1jdu/317JQ=;
        b=M/YOgGUSd6sSck8mbSCljFquAlCi9qlh0cgsjR0AYxph8XLj0De3Gt+EKsXKdMJERD
         OyPbLACY1cd6up9CsWaDm0jWE3a2TWL2OpBKmD07es2byf+OGxYFgo+JfSnTEohslRm3
         v0HRR8aKvLaEfHhXvCiZwggEZJ+rTnzYnCVy8qUz+z5edBslpuOP6N98avN2Z2ydyE5H
         rA5qz/dB5w7/7yPK3GJBHO0f1+Ztdsq5LB6HBhSZUsbYENtf+hD/HCYQcxMmNKn+1m93
         vGPZ+XeM4NqX3NR6Eto1kKmris72xTszjT5okXsJlp8XPU61zZFZWJfxJspNWOKF4qV/
         1zeA==
X-Forwarded-Encrypted: i=1; AJvYcCUOZg52ovU6fBE5TUtv8lQ13syQlyogZBBEfRMogim/GiG0bUID7w9cnxU+7fofbadYJXc+qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyvYUkvmuAdpHkpqgcL9sUqv2neN2oAt9v5eMcQ/7c5j2plY17
	QFWM9fWPuu2mOJJq1i8g47pCONffliMh7pwMlmf9aWvYxcZ/EyItFHAl8LhqMmzwiJxS+2BIdqW
	GHQ==
X-Google-Smtp-Source: AGHT+IEkkZsY8ruaiafHFgvGKu+qq4+sFmbSt1BxoMGSqk6S6uLwO7DhByw4VjeW33u71GKRfK37WDJpDHQ=
X-Received: from pjbdb3.prod.google.com ([2002:a17:90a:d643:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d501:b0:223:90ec:80f0
 with SMTP id d9443c01a7336-22ac29a85demr8617275ad.22.1744145493932; Tue, 08
 Apr 2025 13:51:33 -0700 (PDT)
Date: Tue, 8 Apr 2025 13:51:32 -0700
In-Reply-To: <cf4d9b81-c1ab-40a6-8c8c-36ad36b9be63@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-34-seanjc@google.com>
 <cf4d9b81-c1ab-40a6-8c8c-36ad36b9be63@redhat.com>
Message-ID: <Z_WFolTVWQtkoNIU@google.com>
Subject: Re: [PATCH 33/67] KVM: x86: Dedup AVIC vs. PI code for identifying
 target vCPU
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 08, 2025, Paolo Bonzini wrote:
> On 4/4/25 21:38, Sean Christopherson wrote:
> > Hoist the logic for identifying the target vCPU for a posted interrupt
> > into common x86.  The code is functionally identical between Intel and
> > AMD.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/include/asm/kvm_host.h |  3 +-
> >   arch/x86/kvm/svm/avic.c         | 83 ++++++++-------------------------
> >   arch/x86/kvm/svm/svm.h          |  3 +-
> >   arch/x86/kvm/vmx/posted_intr.c  | 56 ++++++----------------
> >   arch/x86/kvm/vmx/posted_intr.h  |  3 +-
> >   arch/x86/kvm/x86.c              | 46 +++++++++++++++---
> 
> Please use irq.c, since (for once) there is a file other than x86.c that can
> be used.

Hah, will do.  I honestly forget that irq.c and irq_comm.c exist on a regular
basis.

> Bonus points for merging irq_comm.c into irq.c (IIRC irq_comm.c was "common"
> between ia64 and x86 :)).

With pleasure :-)
