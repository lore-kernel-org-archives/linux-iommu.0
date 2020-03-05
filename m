Return-Path: <SRS0=kRV3=4W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E0C3F2D1
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 15:43:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B2B2073D
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmcVU6je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B2B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19A2C87D7B;
	Thu,  5 Mar 2020 15:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoUZvZSjX64x; Thu,  5 Mar 2020 15:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AF7587D8B;
	Thu,  5 Mar 2020 15:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5474DC18DA;
	Thu,  5 Mar 2020 15:43:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95D89C013E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7F47986AC7
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMwid-G6jSZz for <iommu@lists.linux-foundation.org>;
 Thu,  5 Mar 2020 15:43:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C3D9D83491
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583422980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5mw+5LGP9RE5YEazC7GDzkU8nm5NgoMOCIQaMpmC7k=;
 b=FmcVU6jeF7BAiwFEpYuZPoOox9BJcYEP3Nl47aPq0jNme9xeQnyMJwI2AFjz3hdMdLdnm5
 vNlsghqJhr9Bz+ByLNN0RCrOKTKB+ybjoh04kYFqXIwyTwv15fQfwVuy32EXZ7hqgl8EUB
 NuxsBGPr/nLrg8n4tV0wVCDOd4mvZIE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-0EriP99sPSGDtBTC23qCbg-1; Thu, 05 Mar 2020 10:42:59 -0500
X-MC-Unique: 0EriP99sPSGDtBTC23qCbg-1
Received: by mail-qv1-f71.google.com with SMTP id w13so3250628qvk.8
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 07:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v5mw+5LGP9RE5YEazC7GDzkU8nm5NgoMOCIQaMpmC7k=;
 b=hZGyY7J073YkyHyJw+WgkDi1X8gFmXJWelXAMTy+MjjZxmQXvK9SJejC/1zNBKk2eY
 hN+KlzKnoNKfrCo9Qiz7vENIR4or+CBcG1vDwvsV7q4BDvxCStB9btrcLkOHnmI5Ul5X
 P8Yc8oEfTPnElVtPVxsIZf+TukZ6exL2PDfrhl7ymzQTPn8bGGhAhQ1IvBzWRK2IxM0L
 AZ7JoGKQnS9u9IfhsTwoAFFMoNOodBPauobwvSOEdvT8LfTtxr5HW4n9mVBKBwZI5f+k
 UxpPYK4nebtW8njBGBzIX0F6kB18HP6YZyvvvwn0Qj2wT7xFyEq+p9rqiqvO39b0TlsE
 +xrg==
X-Gm-Message-State: ANhLgQ0dz+5f3tlQvm1lQP58RRIrPBinuv7K6ld4YWahkpEr0fjNTEzu
 O40zKreWA7J7UeNPZAU7ms6vaEeRKVOoOBBovgqvg5ttUmd9AvlqdEjvAnzkjeLbTW9lv1r4FhP
 zlOtbQptoW33Pcx/IbZDa5j2T5jRheA==
X-Received: by 2002:a05:6214:1404:: with SMTP id
 n4mr6985878qvx.237.1583422978690; 
 Thu, 05 Mar 2020 07:42:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vupwTlYbbOVLm7I6MzJJZnvoKTQidVVSGtwHtFKHWgU4GKKZRAi3AoaWmSSz3B5Prm1w8y2nQ==
X-Received: by 2002:a05:6214:1404:: with SMTP id
 n4mr6985848qvx.237.1583422978417; 
 Thu, 05 Mar 2020 07:42:58 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
 by smtp.gmail.com with ESMTPSA id n8sm15851215qke.37.2020.03.05.07.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 07:42:57 -0800 (PST)
Date: Thu, 5 Mar 2020 10:42:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200305104002-mutt-send-email-mst@kernel.org>
References: <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org> <20200304153821.GE646000@myrica>
 <20200304174045.GC3315@8bytes.org>
 <20200304133744.00000fdb@intel.com>
 <20200304215449.GE3315@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200304215449.GE3315@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Rothman, Michael A" <michael.a.rothman@intel.com>, linux-pci@vger.kernel.org,
 jasowang@redhat.com, "Kaneda, Erik" <erik.kaneda@intel.com>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, "Jacob Pan \(Jun\)" <jacob.jun.pan@intel.com>,
 bhelgaas@google.com, robin.murphy@arm.com
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

On Wed, Mar 04, 2020 at 10:54:49PM +0100, Joerg Roedel wrote:
> On Wed, Mar 04, 2020 at 01:37:44PM -0800, Jacob Pan (Jun) wrote:
> > + Mike and Erik who work closely on UEFI and ACPICA.
> > 
> > Copy paste Erik's initial response below on how to get a new table,
> > seems to confirm with the process you stated above.
> > 
> > "Fairly easy. You reserve a 4-letter symbol by sending a message
> > requesting to reserve the signature to Mike or the ASWG mailing list or
> > info@acpi.info
> 
> Great! I think this is going to be the path forward here.
> 
> Regards,
> 
> 	Joerg

I don't, I don't see why we should bother with ACPI. This is a PV device
anyway, we can just make it self-describing. The need for extra firmware
on some platforms is a bug not a feature. No point in emulating that.

> > 
> > There is also another option. You can have ASWG own this new table so
> > that not one entity or company owns the new table."

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
