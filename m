Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEDC433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 00:19:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BC820738
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 00:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kuNLcV7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BC820738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 527A720410;
	Sun,  2 Aug 2020 00:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RL130t0WnlqZ; Sun,  2 Aug 2020 00:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8CC342037E;
	Sun,  2 Aug 2020 00:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BDCCC0050;
	Sun,  2 Aug 2020 00:19:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99FCCC004D
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 00:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9584285F63
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 00:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vhKwEL4XjiN for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 00:19:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB99285D50
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 00:19:05 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id c15so1392629lfi.3
 for <iommu@lists.linux-foundation.org>; Sat, 01 Aug 2020 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=OG3AD5yCwDKeg5Wj7pBRf01bF7dmitd9Y1Q0pfVNMbw=;
 b=kuNLcV7quzpSxVpbYSNNirV/1RGz7WsAq8qim4tNQjwXP0Ont8YaOkl2ZPQ2dIYIdo
 XkZTa9TP3eQuXnlvMFzfJeBpML/wNLtQy+TxA1IdOQnu6WpyAlEHYHe/a/jN7HSrRZwU
 Sseli6DTZSsQEmIo/KE3shD2d2R8mQ3D6nLwTN+QYNb2X0hqfBQ54fpjwlY++HEuBHY1
 LTwDb3zltSPS2XPEuQDWrFw5B96udRzBqdM6ffeuK9NI8uRZcoGkrMGUZ2U+5jiFX5HB
 p0Id+4nPXhOkQzvYEDi/sSfdbS1nxJH7fQ2oPla7ez52F8GitAAT354SuuuCptbV70fF
 dJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=OG3AD5yCwDKeg5Wj7pBRf01bF7dmitd9Y1Q0pfVNMbw=;
 b=jmkj7edHucPjqpfw+sBWYn9bzdgRJ1X+fcuyvi8r007MBKljdNM/kMh06BwYXeQGdJ
 ZIKLpt++T+x4mEfRW9Ny3OvHoXyrhgULBut64k7VOsOCb4YvBLY3mHH1fSCXycWEbkNQ
 fyqM4FyraAEVy1eJ8D65ZDlZvzLvHw/bGhvb8IzKRGZj3VXUNgD2PvNRz0ajErqYDrPH
 0eszD+Dq9ZvpcXOLsBFElXL2jIgAzRciOwYx6cNIS99N9bqZVPG/LqnAwkm3fHHFEkaT
 gBz1r4ES6ziRkyUqsjSPMZgfxKXGupbhHxFbxYb43WDVLeJXDe7RIrQtqXcMSOf9qGOt
 0tLQ==
X-Gm-Message-State: AOAM533CXL4gjXZUSWv/wKdgDqS8m3wH5dmKsfQTm3cpoMtjNJMNzTRJ
 jmKtJEah+1lWZSWy8tGJSoVLmEeYxLTHVp42aUbC1g==
X-Google-Smtp-Source: ABdhPJzWdS/N/q8JyPr0fKq7L4pKcw3ezsg2oSw9uDI/hTwWHpg6J5Hvw1n12LxUkwt1n8fYfP7Em6RtP8VUAKX9xs4=
X-Received: by 2002:a19:8c9:: with SMTP id 192mr5234769lfi.204.1596327543433; 
 Sat, 01 Aug 2020 17:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200714201540.3139140-1-rajatja@google.com>
In-Reply-To: <20200714201540.3139140-1-rajatja@google.com>
Date: Sat, 1 Aug 2020 17:18:27 -0700
Message-ID: <CACK8Z6EwSg1JpBTUdPSTwbA9ufbuhhCCC81JCLzLaYom4iJUmA@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/ACS: Enable PCI_ACS_TB and disable only when
 needed for ATS
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, 
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>, 
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Raj Ashok <ashok.raj@intel.com>, 
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Oliver O'Halloran" <oohall@gmail.com>, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: multipart/mixed; boundary="===============4909032879470842731=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4909032879470842731==
Content-Type: multipart/alternative; boundary="0000000000002c55a405abd9f85e"

--0000000000002c55a405abd9f85e
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Tue, Jul 14, 2020 at 1:15 PM Rajat Jain <rajatja@google.com> wrote:

> The ACS "Translation Blocking" bit blocks the translated addresses from
> the devices. We don't expect such traffic from devices unless ATS is
> enabled on them. A device sending such traffic without ATS enabled,
> indicates malicious intent, and thus should be blocked.
>
> Enable PCI_ACS_TB by default for all devices, and it stays enabled until
> atleast one of the devices downstream wants to enable ATS. It gets
> disabled to enable ATS on a device downstream it, and then gets enabled
> back on once all the downstream devices don't need ATS.
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
>

Just checking to see if you got a chance to look at this V5 patch.

Thanks & Best Regards,

Rajat



> ---
> Note that I'm ignoring the devices that require quirks to enable or
> disable ACS, instead of using the standard way for ACS configuration.
> The reason is that it would require adding yet another quirk table or
> quirk function pointer, that I don't know how to implement for those
> devices, and will neither have the devices to test that code.
>
> v5: Enable TB and disable ATS for all devices on boot. Disable TB later
>     only if needed to enable ATS on downstream devices.
> v4: Add braces to avoid warning from kernel robot
>     print warning for only external-facing devices.
> v3: print warning if ACS_TB not supported on external-facing/untrusted
> ports.
>     Minor code comments fixes.
> v2: Commit log change
>
>  drivers/pci/ats.c   |  5 ++++
>  drivers/pci/pci.c   | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c |  2 +-
>  include/linux/pci.h |  2 ++
>  5 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index b761c1f72f67..e2ea9083f30f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -28,6 +28,9 @@ void pci_ats_init(struct pci_dev *dev)
>                 return;
>
>         dev->ats_cap = pos;
> +
> +       dev->ats_enabled = 1; /* To avoid WARN_ON from pci_disable_ats() */
> +       pci_disable_ats(dev);
>  }
>
>  /**
> @@ -82,6 +85,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>         }
>         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>
> +       pci_disable_acs_trans_blocking(dev);
>         dev->ats_enabled = 1;
>         return 0;
>  }
> @@ -102,6 +106,7 @@ void pci_disable_ats(struct pci_dev *dev)
>         ctrl &= ~PCI_ATS_CTRL_ENABLE;
>         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>
> +       pci_enable_acs_trans_blocking(dev);
>         dev->ats_enabled = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_ats);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 73a862782214..614e3c1e8c56 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -876,6 +876,9 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>         /* Upstream Forwarding */
>         ctrl |= (cap & PCI_ACS_UF);
>
> +       /* Translation Blocking */
> +       ctrl |= (cap & PCI_ACS_TB);
> +
>         pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
>  }
>
> @@ -904,6 +907,60 @@ static void pci_enable_acs(struct pci_dev *dev)
>         pci_disable_acs_redir(dev);
>  }
>
> +void pci_disable_acs_trans_blocking(struct pci_dev *pdev)
> +{
> +       u16 cap, ctrl, pos;
> +       struct pci_dev *dev;
> +
> +       if (!pci_acs_enable)
> +               return;
> +
> +       for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
> +
> +               pos = dev->acs_cap;
> +               if (!pos)
> +                       continue;
> +
> +               /*
> +                * Disable translation blocking when first downstream
> +                * device that needs it (for ATS) wants to enable ATS
> +                */
> +               if (++dev->ats_dependencies == 1) {
> +                       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> +                       pci_read_config_word(dev, pos + PCI_ACS_CTRL,
> &ctrl);
> +                       ctrl &= ~(cap & PCI_ACS_TB);
> +                       pci_write_config_word(dev, pos + PCI_ACS_CTRL,
> ctrl);
> +               }
> +       }
> +}
> +
> +void pci_enable_acs_trans_blocking(struct pci_dev *pdev)
> +{
> +       u16 cap, ctrl, pos;
> +       struct pci_dev *dev;
> +
> +       if (!pci_acs_enable)
> +               return;
> +
> +       for (dev = pdev; dev; dev = pci_upstream_bridge(pdev)) {
> +
> +               pos = dev->acs_cap;
> +               if (!pos)
> +                       continue;
> +
> +               /*
> +                * Enable translation blocking when last downstream device
> +                * that depends on it (for ATS), doesn't need ATS anymore
> +                */
> +               if (--dev->ats_dependencies == 0) {
> +                       pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> +                       pci_read_config_word(dev, pos + PCI_ACS_CTRL,
> &ctrl);
> +                       ctrl |= (cap & PCI_ACS_TB);
> +                       pci_write_config_word(dev, pos + PCI_ACS_CTRL,
> ctrl);
> +               }
> +       }
> +}
> +
>  /**
>   * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
>   * @dev: PCI device to have its BARs restored
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12fb79fbe29d..f5d8ecb6ba96 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -552,6 +552,8 @@ static inline int
> pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>         return -ENOTTY;
>  }
>  #endif
> +void pci_disable_acs_trans_blocking(struct pci_dev *dev);
> +void pci_enable_acs_trans_blocking(struct pci_dev *dev);
>
>  /* PCI error reporting and recovery */
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8c40c00413e7..e2ff3a94e621 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2387,10 +2387,10 @@ static void pci_init_capabilities(struct pci_dev
> *dev)
>         pci_vpd_init(dev);              /* Vital Product Data */
>         pci_configure_ari(dev);         /* Alternative Routing-ID
> Forwarding */
>         pci_iov_init(dev);              /* Single Root I/O Virtualization
> */
> +       pci_acs_init(dev);              /* Access Control Services */
>         pci_ats_init(dev);              /* Address Translation Services */
>         pci_pri_init(dev);              /* Page Request Interface */
>         pci_pasid_init(dev);            /* Process Address Space ID */
> -       pci_acs_init(dev);              /* Access Control Services */
>         pci_ptm_init(dev);              /* Precision Time Measurement */
>         pci_aer_init(dev);              /* Advanced Error Reporting */
>         pci_dpc_init(dev);              /* Downstream Port Containment */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7a40cd5caed0..31da4355f0fd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -480,6 +480,8 @@ struct pci_dev {
>         u16             ats_cap;        /* ATS Capability offset */
>         u8              ats_stu;        /* ATS Smallest Translation Unit */
>  #endif
> +       /* Total number of downstream devices below a bridge that need ATS
> */
> +       u8              ats_dependencies;
>  #ifdef CONFIG_PCI_PRI
>         u16             pri_cap;        /* PRI Capability offset */
>         u32             pri_reqs_alloc; /* Number of PRI requests
> allocated */
> --
> 2.27.0.389.gc38d7665816-goog
>
>

--0000000000002c55a405abd9f85e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Bjorn,</div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 14, 2020 at 1:15 PM =
Rajat Jain &lt;<a href=3D"mailto:rajatja@google.com">rajatja@google.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The =
ACS &quot;Translation Blocking&quot; bit blocks the translated addresses fr=
om<br>
the devices. We don&#39;t expect such traffic from devices unless ATS is<br=
>
enabled on them. A device sending such traffic without ATS enabled,<br>
indicates malicious intent, and thus should be blocked.<br>
<br>
Enable PCI_ACS_TB by default for all devices, and it stays enabled until<br=
>
atleast one of the devices downstream wants to enable ATS. It gets<br>
disabled to enable ATS on a device downstream it, and then gets enabled<br>
back on once all the downstream devices don&#39;t need ATS.<br>
<br>
Signed-off-by: Rajat Jain &lt;<a href=3D"mailto:rajatja@google.com" target=
=3D"_blank">rajatja@google.com</a>&gt;<br></blockquote><div><br></div><div>=
Just checking to see if you got a chance to look at this V5 patch.</div><di=
v><br></div><div>Thanks &amp; Best Regards,</div><div><br></div><div>Rajat<=
/div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
---<br>
Note that I&#39;m ignoring the devices that require quirks to enable or<br>
disable ACS, instead of using the standard way for ACS configuration.<br>
The reason is that it would require adding yet another quirk table or<br>
quirk function pointer, that I don&#39;t know how to implement for those<br=
>
devices, and will neither have the devices to test that code.<br>
<br>
v5: Enable TB and disable ATS for all devices on boot. Disable TB later<br>
=C2=A0 =C2=A0 only if needed to enable ATS on downstream devices.<br>
v4: Add braces to avoid warning from kernel robot<br>
=C2=A0 =C2=A0 print warning for only external-facing devices.<br>
v3: print warning if ACS_TB not supported on external-facing/untrusted port=
s.<br>
=C2=A0 =C2=A0 Minor code comments fixes.<br>
v2: Commit log change<br>
<br>
=C2=A0drivers/pci/ats.c=C2=A0 =C2=A0|=C2=A0 5 ++++<br>
=C2=A0drivers/pci/pci.c=C2=A0 =C2=A0| 57 ++++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0drivers/pci/pci.h=C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0drivers/pci/probe.c |=C2=A0 2 +-<br>
=C2=A0include/linux/pci.h |=C2=A0 2 ++<br>
=C2=A05 files changed, 67 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c<br>
index b761c1f72f67..e2ea9083f30f 100644<br>
--- a/drivers/pci/ats.c<br>
+++ b/drivers/pci/ats.c<br>
@@ -28,6 +28,9 @@ void pci_ats_init(struct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;ats_cap =3D pos;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;ats_enabled =3D 1; /* To avoid WARN_ON =
from pci_disable_ats() */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_disable_ats(dev);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -82,6 +85,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_write_config_word(dev, dev-&gt;ats_cap + PC=
I_ATS_CTRL, ctrl);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_disable_acs_trans_blocking(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;ats_enabled =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -102,6 +106,7 @@ void pci_disable_ats(struct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl &amp;=3D ~PCI_ATS_CTRL_ENABLE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_write_config_word(dev, dev-&gt;ats_cap + PC=
I_ATS_CTRL, ctrl);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_acs_trans_blocking(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;ats_enabled =3D 0;<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(pci_disable_ats);<br>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c<br>
index 73a862782214..614e3c1e8c56 100644<br>
--- a/drivers/pci/pci.c<br>
+++ b/drivers/pci/pci.c<br>
@@ -876,6 +876,9 @@ static void pci_std_enable_acs(struct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Upstream Forwarding */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl |=3D (cap &amp; PCI_ACS_UF);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Translation Blocking */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl |=3D (cap &amp; PCI_ACS_TB);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_write_config_word(dev, pos + PCI_ACS_CTRL, =
ctrl);<br>
=C2=A0}<br>
<br>
@@ -904,6 +907,60 @@ static void pci_enable_acs(struct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_disable_acs_redir(dev);<br>
=C2=A0}<br>
<br>
+void pci_disable_acs_trans_blocking(struct pci_dev *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 cap, ctrl, pos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pci_acs_enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (dev =3D pdev; dev; dev =3D pci_upstream_br=
idge(pdev)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D dev-&gt;acs=
_cap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pos)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Disable translat=
ion blocking when first downstream<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * device that need=
s it (for ATS) wants to enable ATS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (++dev-&gt;ats_d=
ependencies =3D=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_read_config_word(dev, pos + PCI_ACS_CAP, &amp;cap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_read_config_word(dev, pos + PCI_ACS_CTRL, &amp;ctrl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ctrl &amp;=3D ~(cap &amp; PCI_ACS_TB);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+void pci_enable_acs_trans_blocking(struct pci_dev *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 cap, ctrl, pos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pci_acs_enable)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (dev =3D pdev; dev; dev =3D pci_upstream_br=
idge(pdev)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D dev-&gt;acs=
_cap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pos)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Enable translati=
on blocking when last downstream device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * that depends on =
it (for ATS), doesn&#39;t need ATS anymore<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (--dev-&gt;ats_d=
ependencies =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_read_config_word(dev, pos + PCI_ACS_CAP, &amp;cap);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_read_config_word(dev, pos + PCI_ACS_CTRL, &amp;ctrl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ctrl |=3D (cap &amp; PCI_ACS_TB);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * pci_restore_bars - restore a device&#39;s BAR values (e.g. after w=
ake-up)<br>
=C2=A0 * @dev: PCI device to have its BARs restored<br>
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h<br>
index 12fb79fbe29d..f5d8ecb6ba96 100644<br>
--- a/drivers/pci/pci.h<br>
+++ b/drivers/pci/pci.h<br>
@@ -552,6 +552,8 @@ static inline int pci_dev_specific_disable_acs_redir(st=
ruct pci_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTTY;<br>
=C2=A0}<br>
=C2=A0#endif<br>
+void pci_disable_acs_trans_blocking(struct pci_dev *dev);<br>
+void pci_enable_acs_trans_blocking(struct pci_dev *dev);<br>
<br>
=C2=A0/* PCI error reporting and recovery */<br>
=C2=A0pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,<br>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c<br>
index 8c40c00413e7..e2ff3a94e621 100644<br>
--- a/drivers/pci/probe.c<br>
+++ b/drivers/pci/probe.c<br>
@@ -2387,10 +2387,10 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_vpd_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Vital Product Data */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_configure_ari(dev);=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Alternative Routing-ID Forwarding */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_iov_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Single Root I/O Virtualization */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_acs_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Access Control Services */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_ats_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Address Translation Services */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_pri_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Page Request Interface */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_pasid_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* Process Address Space ID */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_acs_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Access Control Services */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_ptm_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Precision Time Measurement */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_aer_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Advanced Error Reporting */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_dpc_init(dev);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Downstream Port Containment */<br>
diff --git a/include/linux/pci.h b/include/linux/pci.h<br>
index 7a40cd5caed0..31da4355f0fd 100644<br>
--- a/include/linux/pci.h<br>
+++ b/include/linux/pci.h<br>
@@ -480,6 +480,8 @@ struct pci_dev {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ats_cap;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ATS Capability offset */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ats_stu;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ATS Smallest Translation Unit */=
<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Total number of downstream devices below a b=
ridge that need ATS */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ats_dependencies;<br>
=C2=A0#ifdef CONFIG_PCI_PRI<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0pri_cap;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PRI Capability offset */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0pri_reqs_alloc; /* Number of PRI requests allocated */<br>
-- <br>
2.27.0.389.gc38d7665816-goog<br>
<br>
</blockquote></div></div>

--0000000000002c55a405abd9f85e--

--===============4909032879470842731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4909032879470842731==--
