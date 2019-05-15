Return-Path: <SRS0=sIeu=TP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B7C04E53
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 14:07:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA022084E
	for <iommu@archiver.kernel.org>; Wed, 15 May 2019 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA022084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DEF60C84;
	Wed, 15 May 2019 14:07:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 63D7BC5C
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 14:07:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AAF168D
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 14:07:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id C043DAEB5;
	Wed, 15 May 2019 14:07:36 +0000 (UTC)
Message-ID: <1557928483.2950.18.camel@suse.com>
Subject: Re: Linux crash when using FTDI FT232R USB to serial converter on
	AMD boards.
From: Oliver Neukum <oneukum@suse.com>
To: "StarostaCZ@gmail.com" <starostacz@gmail.com>, Joerg Roedel
	<joro@8bytes.org>, Johan Hovold <johan@kernel.org>
Date: Wed, 15 May 2019 15:54:43 +0200
In-Reply-To: <c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
References: <04503197-a0a9-8b35-6c65-c10f296aab57@gmail.com>
	<20190429094847.GI26546@localhost> <20190503153716.GE11605@8bytes.org>
	<8748125e-f360-ff0e-ea15-699bce9e7747@gmail.com>
	<4e7f0267-eba8-81c3-4036-25924ea9df98@gmail.com>
	<1557911856.2950.10.camel@suse.com>
	<3e7ec2f2-ac47-a031-96ba-fa2b9f21ed2e@gmail.com>
	<1557913582.2950.15.camel@suse.com>
	<c57ccafd-7ad4-63e4-54c1-e1fb136ebeed@gmail.com>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============6785943627089458482=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============6785943627089458482==
Content-Type: multipart/alternative; boundary="=-Xva6C9v4otND/cFVule0"


--=-Xva6C9v4otND/cFVule0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mi, 2019-05-15 at 13:21 +0200,  StarostaCZ@gmail.com  wrote:
>     Dne 15.5.2019 v 11:46 Oliver Neukum napsal(a):
> 
>     
> >       Most helpful. First, try to replicate this with the iommu
> >         disabled.
> >     
> 
>     I am trying this with "iommu disabled" in bios, but system crash
>     too: https://paste.ee/p/wUgHl
> 
>     
> 
>     
> >       Secondly, make a proper bugreport mentioning the affected
> >         kernel version (5.1)
> >     
> 
>     How can I do this?

1. Determine whether the bug depends on the use of an IOMMU
2.Send a new report to the corresponding mailing list

>     
> 
>     
> >       Thirdly, if possible replicate this with the vanilla kernel
> >         from kernel.org
> >     
> 
>     I am afraid, that is not possible. My skills is not too good - is
>     there some procedure to how do this?
> 
>     I made test with mainline kernel 5.1.2 from
>     https://kernel.ubuntu.com/~kernel-ppa/mainline/
> 
>     but computer crash on boot (kernel panic: unable to mount root
>     fs...).

Your initrd has most likely not included a driver for the filesystem on
your root device.

	Regards
		Oliver


--=-Xva6C9v4otND/cFVule0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body><div>On Mi, 2019-05-15 at 13:21 +0200,  StarostaCZ@gmail.com  wrote:</div><blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
    Dne 15.5.2019 v 11:46 Oliver Neukum napsal(a):<br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
      <div>Most helpful. First, try to replicate this with the iommu
        disabled.</div>
    </blockquote>
    I am trying this with "iommu disabled" in bios, but system crash
    too: <a class="moz-txt-link-freetext" href="https://paste.ee/p/wUgHl">https://paste.ee/p/wUgHl</a><br>
    <br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
      <div>Secondly, make a proper bugreport mentioning the affected
        kernel version (5.1)</div>
    </blockquote>
    How can I do this?<br></blockquote><div><br></div><div>1. Determine whether the bug depends on the use of an IOMMU</div><div>2.Send a new report to the corresponding mailing list</div><div><br></div><blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
    <br>
    <blockquote type="cite" cite="mid:1557913582.2950.15.camel@suse.com" style="margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1ex">
      <div>Thirdly, if possible replicate this with the vanilla kernel
        from kernel.org</div>
    </blockquote>
    I am afraid, that is not possible. My skills is not too good - is
    there some procedure to how do this?<br>
    I made test with mainline kernel 5.1.2 from
    <a class="moz-txt-link-freetext" href="https://kernel.ubuntu.com/~kernel-ppa/mainline/">https://kernel.ubuntu.com/~kernel-ppa/mainline/</a><br>
    but computer crash on boot (kernel panic: unable to mount root
    fs...).<br></blockquote><div><br></div><div>Your initrd has most likely not included a driver for the filesystem on</div><div>your root device.</div><div><br></div><div>	Regards</div><div>		Oliver</div><div><br></div></body></html>
--=-Xva6C9v4otND/cFVule0--


--===============6785943627089458482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6785943627089458482==--

