Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF2C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 07:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7E3160BAF;
	Fri,  6 May 2022 07:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gFp1e-mRDfWu; Fri,  6 May 2022 07:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8084660BAE;
	Fri,  6 May 2022 07:11:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62190C0032;
	Fri,  6 May 2022 07:11:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67999C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4113660BAF
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymPeXJr6HAqH for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 07:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D24E60BAE
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:10:58 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4AA4F21A32;
 Fri,  6 May 2022 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651821055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iobKkEjSGTbzqIJvKfuI7vLuxiRZWSHjoZywPn+nWM=;
 b=JLzFkU7xwY1ZjXdLarT8pGQVzBIanoEu2BZbq3GvSexWXwgPNyG7Mkxun4xI0NgKpH107P
 Hh3QQVAdxF9bEDkBDQRgc6gf4nmsFNS9GuZUy06M3mpIXiyhI1BQ3+HXriMBlC3nr/s3bm
 kiKb8ot+qoRNGjwe0dokvV6yCj8ZQZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651821055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iobKkEjSGTbzqIJvKfuI7vLuxiRZWSHjoZywPn+nWM=;
 b=SxdCT94BeiSi1w3l3sLoYE1hGpncMHwq5a+oiwnWXz0ke41qMs8opB1mVjp0SNPToo7kA/
 uC5lgdhQHpQ+8gBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E418413AA2;
 Fri,  6 May 2022 07:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id osEbNv7JdGIhHwAAMHmgww
 (envelope-from <jroedel@suse.de>); Fri, 06 May 2022 07:10:54 +0000
Date: Fri, 6 May 2022 09:10:53 +0200
From: "Rodel, Jorg" <jroedel@suse.de>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Message-ID: <YnTJ/YqQpru3YPC+@suse.de>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Anderson,
 Russ" <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 06, 2022 at 06:49:43AM +0000, Tian, Kevin wrote:
> another nit: dmar is intel specific thus CONFIG_X86 is always true.

There are Itanium systems which have DMAR units. Is that no longer
supported?

Regards,

-- =

J=F6rg R=F6del
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=FCrnberg
Germany
 =

(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Ivo Totev

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
