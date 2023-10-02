Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054451F19E
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 19:21:28 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d814634fe4bso125397276.1
        for <iommu@lists.linux.dev>; Mon, 02 Oct 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696274488; x=1696879288; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6T5u8n63H32m/YuZ6al8a5T5YBKCODxao+/slOadeI=;
        b=WTUE+yT8o6EskfEBsxHMhiylkRJMnFVGmDXCOoNZ2zJasvlc09H9vQORSS4jxUCehZ
         bnyvlO1gCSqakBiI9e+bd1ZMQZCnJ/xMFwKyrUuuOKIcKLi8XRT700BZZ0g81ksrJGpx
         TB6Xzt2z5iBbDo9jDE50JBMe0IRaamF4FH6xixejrlCFb3b4iaJvzEE3QmZgTyjRQykO
         7Jor5cPvA81A3THAyOwJW/tobD/HVQyqtHcVIiNM4ajEL4LR0PIQ1Byi2rk2l9dyGtdN
         KWLY37k9b5k4QJWtDLOq1YuJbhPpN36YG6bfsGj0Cc5Tt7+HEDetek93w9RZvyf8ho7c
         W0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274488; x=1696879288;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6T5u8n63H32m/YuZ6al8a5T5YBKCODxao+/slOadeI=;
        b=LW4p2tI4L9xKEMLDnYrhuKs1MS9OJAmZOLWTNnIrFCBs7Vd+2nPYxsM4ZOYjZrhuWX
         xtFrSO+n34DXKWzbFRTxo3pU9LeW/F9YfwKF5zi0FrRLhy/1XdIfivgSq02Ppuj8UpTg
         jsONd45oSRELdvVFbfQD+wRlmNw8jvCYRfiIlCX6zSugTJb83dGCaIne5T9wNVascHhz
         8uPrYTJMrNLW/eF1KP6Ii/U9v2wmVCIu1olr48nPDXpNCpR4OWmiqXPeTpCbSj6Hs3Dv
         uKK5Dv8bYvtDvmRgrvvqnDIBuXDJrBuWpjV5ZPTtbaAxdh1yqBqVfE2/bZkXh9z72GQ4
         Ze4A==
X-Gm-Message-State: AOJu0YztBnZAM7pwtRY1UsEcEa4CTOAGphpFsjcUziwF1aOXgc7+O8Rs
	xAdDXsVVNKZL0V/dl5is0OcYxqNPNTA=
X-Google-Smtp-Source: AGHT+IHtmSpMO46KvblpohsWz6O2OSsiMptb0VeaGAhA3nbdHgcxj9vvtm/o9rpvvprle6yfo7JS3Vq54xM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2d12:0:b0:d7e:8dee:7813 with SMTP id
 t18-20020a252d12000000b00d7e8dee7813mr200701ybt.8.1696274487816; Mon, 02 Oct
 2023 12:21:27 -0700 (PDT)
Date: Mon, 2 Oct 2023 12:21:26 -0700
In-Reply-To: <20231002115723.175344-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com>
Message-ID: <ZRsYNnYEEaY1gMo5@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> Hi!
> 
> This patch allows AVIC's ICR emulation to be optional and thus allows
> to workaround AVIC's errata #1235 by disabling this portion of the feature.
> 
> This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> review feedback.

Please respond to my idea[*] instead of sending more patches.  I'm not opposed to
a different approach, but we need to have an actual discussion around the pros and
cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
that there is an alternative proposal, let alone justify why the vcpu->loaded
approach was taken.

[*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
