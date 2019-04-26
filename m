Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5ADC43219
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:28:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FD02077B
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FD02077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1CF662822;
	Fri, 26 Apr 2019 15:28:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A34E6286B
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 30C2182A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:26:36 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 726E6AB7D;
	Fri, 26 Apr 2019 15:26:34 +0000 (UTC)
Date: Fri, 26 Apr 2019 17:26:32 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
Message-ID: <20190426152632.GC3173@suse.de>
References: <1556290348.6132.6.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1556290348.6132.6.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426152632.BuExBmkNQ9VAmrGCnCqNtkMAe4-RCkvM9381LqMtDcA@z>

On Fri, Apr 26, 2019 at 10:52:28AM -0400, Qian Cai wrote:
> Applying some memory pressure would causes smartpqi offline even in today=
's
> linux-next. This can always be reproduced by a LTP test cases [1] or some=
times
> just compiling kernels.
> =

> Reverting the commit "iommu/amd: Set exclusion range correctly"=A0fixed t=
he issue.
> =

> [=A0=A0213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_F=
AULT
> domain=3D0x0000 address=3D0x1000 flags=3D0x0000]
> [=A0=A0213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_F=
AULT
> domain=3D0x0000 address=3D0x1800 flags=3D0x0000]
> [=A0=A0233.362013] smartpqi 0000:23:00.0: controller is offline: status c=
ode 0x14803
> [=A0=A0233.369359] smartpqi 0000:23:00.0: controller offline
> [=A0=A0233.388915] print_req_error: I/O error, dev sdb, sector 3317352 fl=
ags 2000001
> [=A0=A0233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result: hostb=
yte=3D0x01
> driverbyte=3D0x00
> [=A0=A0233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=3D0x2a 2a 00 00 5=
5 89 00 00 01
> 08 00
> [=A0=A0233.389003] Write-error on swap-device (254:1:4474640)
> [=A0=A0233.389015] Write-error on swap-device (254:1:2190776)
> [=A0=A0233.389023] Write-error on swap-device (254:1:8351936)
> =

> [1] /opt/ltp/testcases/bin/mtest01 -p80 -w

I can't explain that, can you please boot with 'amd_iommu_dump' on the
kernel command line and send me dmesg after boot?

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
