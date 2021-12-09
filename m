Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E8C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 05:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BADB4408F5;
	Thu,  9 Dec 2021 05:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NGtBhOo-ERvG; Thu,  9 Dec 2021 05:47:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9ACAF408F2;
	Thu,  9 Dec 2021 05:47:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 536AEC0012;
	Thu,  9 Dec 2021 05:47:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2F8BC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 05:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD94882BC0
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 05:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TZhC8BCWIich for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67D3282BBC
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 05:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639028851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
 b=E8Z6RRx5gT5mcb7jnlunYCPofg6v/fj9Nllwn14Cf8dAknjiD0JqIM1Ekxja1n9VTxQh16
 ZZ8DpvM24nX87vmOTf5kHRE0HwXuSEOXSfeJwKzPn6mugFwWBuVyWZVsQdONDwUcgiZxWN
 JqWQbY6nhU3/EZDP8ZmsLpQ9j9IOeV8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-s_b3vfmNNgacCVBYjl_35Q-1; Thu, 09 Dec 2021 00:47:29 -0500
X-MC-Unique: s_b3vfmNNgacCVBYjl_35Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 bi30-20020a0565120e9e00b00415d0e471e0so2185789lfb.19
 for <iommu@lists.linux-foundation.org>; Wed, 08 Dec 2021 21:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MTAn1ztGmocc9lVa3A3/+M3LMLwmgt1eLb7L68uXAdc=;
 b=ypdkpIpBrMHpx4IYAe+8Htb9xXv2epiGKmCoqCd8llTx3b5pJQuDhQMRncnqx0t35x
 Kt7W5E3M8+4rtbEqL/4i+XDSvCeK0KYv1C3B+cTY3kaO+H5DA8R0gdu+HDuiwqtEVnxK
 Bkx19CFHlgQPT7P/CKuqmxCAw0q6XsUCym0EQ/hCHe5wRzTsJEDFw5CHuYD1Tp4sYfO+
 pbKgodHndPIlAIQJ8qommScVg/yPwrU3j3mR6x+HU3hC8BmjXeff+6GbhnWMiPFBllIR
 ou67Q4vXndyT/epIMiQtnfw8b5wjxfxkWMiViCNnUT1Rhdmp1+GgKTzIrPvN+BalH524
 eLzw==
X-Gm-Message-State: AOAM533kf2Klw+9327Gk0N9dc5xVW8Tjx+qkhE2diSL/OkAz6cl3mfZ7
 Ok/AVoqFt/Dst5J3AdVEoxupxTGe38p3GmIH+mIthzWMYLJWpQWTyAEJ80SCgt0xu+kldGOEdkG
 7qhSnq/8wImeXCmKWcXtCKZzM8k68bmL8BhNkmIOdvyHNog==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000051ljw.217.1639028848304; 
 Wed, 08 Dec 2021 21:47:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq/umBaPtYwDOFSZQvlFRjjQexm+OmnMnO6A8JPT/yt1E5P3J0cUOqEOEr99euJsOw+HZezXtE5wjdaUSNzOc=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr4000032ljw.217.1639028848143; 
 Wed, 08 Dec 2021 21:47:28 -0800 (PST)
MIME-Version: 1.0
References: <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <20211201130023.GH4670@nvidia.com> <87y2548byw.ffs@tglx>
 <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx> <20211202135502.GP4670@nvidia.com>
 <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB527696C0E8D08680FFFB6BAB8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 13:47:17 +0800
Message-ID: <CACGkMEv_b=WLUp1_fUtfaxo9_Y95x=u+Za2-sxTRrmXe-J_jRA@mail.gmail.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: "Tian, Kevin" <kevin.tian@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Thomas Gleixner <tglx@linutronix.de>, Logan Gunthorpe <logang@deltatee.com>,
 "Dey, Megha" <megha.dey@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 9, 2021 at 1:41 PM Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 2, 2021 9:55 PM
> >
> > Further, there is no reason why IMS should be reserved exclusively for
> > VFIO!
>
> This is correct. Just as what you agreed with Thomas, the only difference
> between IMS and MSI is on where the messages are stored. Physically
> it is unreasonable for the HW to check whether an interrupt is used for
> a specific software usage (e.g. virtualization) since it doesn't have such
> knowledge. At most an entry is associated to PASID, but again the PASID
> can be used anywhere.

Note that vDPA had the plan to use IMS for the parent that can have a
huge amount of instances.

Thanks

>
> The wording in current IDXD spec is not clear on this part. We'll talk to
> the spec owner to have it fixed.
>
> Thanks
> Kevin
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
