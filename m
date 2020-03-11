Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A779C0044D
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBEE20736
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZTcEX6f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBEE20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E347C89372;
	Wed, 11 Mar 2020 17:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLKBDw7Ce4JE; Wed, 11 Mar 2020 17:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C82318936E;
	Wed, 11 Mar 2020 17:05:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9DBBC18D3;
	Wed, 11 Mar 2020 17:05:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1496EC0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ECDFD84974
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsJrj4GzJD6V for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 17:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6E2DB8496B
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583946330;
 bh=45C/IaRIhJehtDpal1AuK6vZrVdODReRTFDhskQtxwM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ZTcEX6f/KFZAZ96vZAEao97xI5hwMCb08FwCDdFbz8lJ3vuct9wnhXSL9I9QKoPJQ
 OkGz8FlD963D7bM38QZhcZXXp8RVVHZ+7D9DhX2yTpaliE7+KHSp9uZW//afLT1DS3
 RqSEojhFtBjxlCUjjcwpi0HfJa4oyBoLj2t4q3xA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.81.10.6] ([196.52.84.30]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbkv-1iwzgH1ga3-00P90x; Wed, 11
 Mar 2020 18:05:30 +0100
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <bug-206175-5873@https.bugzilla.kernel.org/>
 <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de>
 <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com>
 <20200311154328.GA24044@lst.de> <20200311154718.GB24044@lst.de>
 <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
 <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
 <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
From: "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <8fb66574-4cce-879c-b15a-3d47eaaef03b@gmx.com>
Date: Wed, 11 Mar 2020 17:05:29 +0000
MIME-Version: 1.0
In-Reply-To: <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
Content-Language: ru
X-Provags-ID: V03:K1:ivnWwQwoK229/COAsWDkQySbMVLGgbWYCxbJMJcOhltEDcRSub9
 Sb2qV/dcDlXoKlSU/Ff4+1s8p5xynh+RWQ9xxiCiyYRO9uRYJYlHDvoyWhr2fohRyrh5O/c
 9hlw4Boq0Z5NFPB5MZZ08aWnUCl2yFtKSCyhorCuhpDDmCcAy2LfiQdIgY5OJejCCjYEpXm
 ttALpGFdZtW8ZibtBNhxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EaN7zs4KfbI=:FwadK1JAb9mZiYnNpwzwby
 fGibassHgvg4CyUe6eL0k1L1sKCtxKLDd95CJg6EdYPaSJlC2T0zMLbeV/JQcmJqz3x+HwEPU
 LCzAK0k7FzTM0H6IIOPffmliIPZdpjzfKJ2DULilyzfoTnQv9bEWepwOBwFqyuSViLwwsbo5u
 iEZb497QLMtDnV0mB1CsDaWqGAOq86aGDL2i4ErctcTf7ow6ZXDb7CgLVRMFpBcPykIv1EcrV
 nJcAch+oVU4j5Ej5+fbxL1+yZvnS6MjGKhhmOZR2naPieuG27gc8IWNIuue2Ye1XpIhDPNscm
 InmB9zUtll/k7dm3xVC9WJMd8UzL/iXBo4oSgTEQNrfAipPF12UH6UeD2RZWOLATQ6NQUW3aj
 wQfavS5p4j4zJ59hrnCUNKI9h5zzozlQnjFk862IroQa+pOc4MADQp/lvDz1l8fQASGVDh7c9
 GyeXAZcPm/TkkZg7FxRmHpvWwCE9/Ju12zqVNGP3HkpstOo5LgK74UPN5Wp52mly0xQ/M4DPa
 wguLng/GyMk+rqWUzwqDHLte62xC3zA7icxy/56QGphumYveV6LciwifW0k5Qv1T9hqsKKF1Z
 ZdokkU339XvNxy/0rl7DqAMi57hQKPkh7ScAmTk2W5bcIEzolS7y6aixm7ju0Bx573xi44H5s
 hf1FKt334e3pjwANKDRr1erR6D2CNu0sIlLR48hpkDmi0sR43UK17Z17DRvcA/OZ7unryihre
 mtcdqdDK7ah2kiCMjm84Cs7WLnhujoLbK2T0eyThxcuBs1+1AClSTDD4E+L6aOMaL4FaSnx3A
 u6j2OmyWY2YkN+OJ/NWPdC3jrkxOEd1tGLX9VbVo5W2+ve+dlFyAwbrtNcxAdM8Fv/8TJTVsF
 8OF0HP/tuU7P1CLIaSXE+ajn6YiZKPf2qPKRdfz3hORKXD/l/R494IdAny+trTYHvq4L/QmHW
 JEs1LHjOwwferfQR8ftj0vzwSdc2uL0vIZjxg/5K98QBSdqIa3lVkr8n/6mZO+L8sXEaKLWJe
 6tyWwHnWu7ts+Q+0Wp+qCAp2+FDiGw40cMNdRALakZ7E6mg/a/smz1PVa20V6EHLfT4MbiuYR
 90NYheZfoZOf4YkkTnpLvkBW1loMPvV3pcjvINrM5OneC6Ot7uxBXTmCUPRb0S8E9HgyTeLMM
 84FHgf9kEytTpgXQ3SZYnPRDznkQSqXLuNnKZV6c7bPuS+HAgG17NSnZzjh70DPFh2X3wubN7
 EhVd4jRjDEVnnP5gB
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 3/11/20 4:48 PM, Linus Torvalds wrote:
> On Wed, Mar 11, 2020 at 9:24 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So it will have a different commit ID, updated message, and be a mix
>> of my patch and Christoph's.
>
> I ended up pushing it out before starting on the pull requests, so
> it's out there now.
>
> Artem, it would be good to have confirmation that my (modified) tip of
> tree now works for you. I don't actually doubt it does, but a final
> confirmation would be appreciated.
>

Should I test kernel 5.6-rc5 with this patch applied or wait for you to
commit it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
