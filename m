Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E94600C
	for <iommu@lists.linux.dev>; Tue,  5 Jul 2022 18:27:31 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31cac89d8d6so48082037b3.2
        for <iommu@lists.linux.dev>; Tue, 05 Jul 2022 11:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDaZJQ1t7WZXHXc1sh5v+s4p6BMcgf4NLI5GY92Hi9Y=;
        b=h3uNzcIuej8FDSK1pWNe9OOdka7XJ8QhBqo2rRuOUNCgVoVFmGfec3XgoSmExKsd/f
         t8TqLJ3zyGkCNTdXyzjLGgn19b7niZmNIsZAea2cFMKdqUq9L7epncvU1U+FZliVl5LF
         CQp9/EICs9QwlVFOY224daN1vcbu1boRCWsgcE8MRST35JlAGfyZ39aPyHsOa1k3oGIW
         4+dZfcCm/p1ZXssi8wCmmKD7CSne13Nz3D9M/5iZbfhDnzroZtXqFqaELjvvZRLCcwP9
         /A5gV7/WGWhy9eCerBdzs8c388b+orRjvmdKFf9Tw5lO03Y3KQ/PJvXupQ6jKbHpleyA
         DqOA==
X-Gm-Message-State: AJIora/qPb8t+TbOuBriK0EA+I9IHyUk/2e8mDtq5VxHoCLqnwYRQoCE
	ICVaY1VsNqgxLH0deDW/Cyh/mvHgixYkDu76J90=
X-Google-Smtp-Source: AGRyM1s2QEn+mZPivlKtPrgixQUmIChTU4gw5ikon89zd7049nfH/7sTVF3gtghrOQrMUchoZ2CX/5thIM3o6KDInik=
X-Received: by 2002:a0d:d8c8:0:b0:31c:92b1:5dec with SMTP id
 a191-20020a0dd8c8000000b0031c92b15decmr14867269ywe.19.1657045650713; Tue, 05
 Jul 2022 11:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220630094059.1204283-1-eric.auger@redhat.com> <Yr1z2gC0+8zbzpFf@myrica>
In-Reply-To: <Yr1z2gC0+8zbzpFf@myrica>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jul 2022 20:27:19 +0200
Message-ID: <CAJZ5v0hqcUUTVzkHxGr9pB5G-T5ye5g_=DQVO6L347DpXipwOg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: VIOT: Fix ACS setup
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Joerg Roedel <jroedel@suse.de>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, 
	jinl@redhat.com
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20220705182719.ifPPJrplKypoB31aM1fXtqnXaHsCTkf0jPRNugrjTrM@z>

On Thu, Jun 30, 2022 at 11:59 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jun 30, 2022 at 11:40:59AM +0200, Eric Auger wrote:
> > Currently acpi_viot_init() gets called after the pci
> > device has been scanned and pci_enable_acs() has been called.
> > So pci_request_acs() fails to be taken into account leading
> > to wrong single iommu group topologies when dealing with
> > multi-function root ports for instance.
> >
> > We cannot simply move the acpi_viot_init() earlier, similarly
> > as the IORT init because the VIOT parsing relies on the pci
> > scan. However we can detect VIOT is present earlier and in
> > such a case, request ACS. Introduce a new acpi_viot_early_init()
> > routine that allows to call pci_request_acs() before the scan.
> >
> > While at it, guard the call to pci_request_acs() with #ifdef
> > CONFIG_PCI.
> >
> > Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reported-by: Jin Liu <jinl@redhat.com>
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Applied as 5.20 material, thanks!
