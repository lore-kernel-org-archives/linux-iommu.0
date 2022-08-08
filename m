Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1B3D88
	for <iommu@lists.linux.dev>; Mon,  8 Aug 2022 17:31:41 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id 199so14707577ybl.9
        for <iommu@lists.linux.dev>; Mon, 08 Aug 2022 10:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XE+n3oen5M0Y6e3hQHkhdlIj+r5EImjvF5ySJ/oi7Gg=;
        b=0gQ9CasHJRU7jCR9efIXWmVK1I5n0mOastyjCY2tTAsKIeKcxc0v7n+XPETPD83Yan
         FKIRrHyvt8vM80Hn1m7MIu1Mxcbu1+Mc13j/XZI4L4tVxn2II/MyaIzAT19WtjrB6CPu
         BMp2G1b1s7iquJi6aAZnvvyxw6QFt86vznMg7Mb6IBiMl9S60BIMqb+1NT9ZGpfNyhZF
         d13pp9SzJPSn3g6SvEVmchQu/rON/caOTeSsjNMZDCUD3I1QgNyeRU3B07SoPxGoHQ01
         NlrWvNqEk/RS/w7aHmyP6N5Z3Q8CtrZuI5VXcFoi580nv/JBT7lfEPnQrpaGUA2dd3gF
         yqBw==
X-Gm-Message-State: ACgBeo29gEwi7Ht6y5mF5NCCj444Ue1IlCkUQCBLHkQoOc3omkOuoqUI
	l6vnW1znF3TG4Z11ovxT3+2pHbud2bYDMA7zgRI=
X-Google-Smtp-Source: AA6agR5upNhWU3fVwvA09Is8RJUsteXtRxDRvkNznDvaCZ5QkgtNuY18SStQsaUE4RmZF5tr5yF2iU53FoXtCcjjfTE=
X-Received: by 2002:a5b:40a:0:b0:677:a43b:dcd3 with SMTP id
 m10-20020a5b040a000000b00677a43bdcd3mr16122549ybp.622.1659979901028; Mon, 08
 Aug 2022 10:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com> <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
In-Reply-To: <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Aug 2022 19:31:30 +0200
Message-ID: <CAJZ5v0i7aqURUA3AOpssKCjucPpyys5-KKWgrujxNwxkg_x-+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct device
To: Eric Auger <eric.auger@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, iommu@lists.linux.dev, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 3, 2022 at 12:03 PM Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Andy,
>
> On 8/2/22 21:35, Andy Shevchenko wrote:
> > In order to make the underneath API easier to change in the future,
> > prevent users from dereferencing fwnode from struct device.
> > Instead, use the specific dev_fwnode() and device_match_fwnode()
> > APIs for that.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Applied, thanks!

> > ---
> >  drivers/acpi/viot.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > index 647f11cf165d..6132092dab2a 100644
> > --- a/drivers/acpi/viot.c
> > +++ b/drivers/acpi/viot.c
> > @@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
> >               return -ENODEV;
> >       }
> >
> > -     fwnode = pdev->dev.fwnode;
> > +     fwnode = dev_fwnode(&pdev->dev);
> >       if (!fwnode) {
> >               /*
> >                * PCI devices aren't necessarily described by ACPI. Create a
> > @@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
> >               }
> >               set_primary_fwnode(&pdev->dev, fwnode);
> >       }
> > -     viommu->fwnode = pdev->dev.fwnode;
> > +     viommu->fwnode = dev_fwnode(&pdev->dev);
> >       pci_dev_put(pdev);
> >       return 0;
> >  }
> > @@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
> >               return -ENODEV;
> >
> >       /* We're not translating ourself */
> > -     if (viommu->fwnode == dev->fwnode)
> > +     if (device_match_fwnode(dev, viommu->fwnode))
> >               return -EINVAL;
> >
> >       ops = iommu_ops_from_fwnode(viommu->fwnode);
>
