Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585FBC433FE
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 09:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E780D419C4;
	Fri, 15 Apr 2022 09:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9U2SynU8bjb; Fri, 15 Apr 2022 09:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81B00419B4;
	Fri, 15 Apr 2022 09:58:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F6AC0033;
	Fri, 15 Apr 2022 09:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2E45C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE01240B9D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GeIVqGaw0USb for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 09:58:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40DB240239
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 09:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650016737; x=1681552737;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CuY8lQWVqoDyp5M/6RY1Ni6Xf6rVDsquQgEJnRIkY8k=;
 b=cmjWc4MugsfnAQIeQy+zJRJ0fuTTw+z4c2il1pemHtk+BxMo9KmE3OSN
 ek+Ueqc1QTxWGupE9r6Q1sud7bG3FVf/nxAlfBmnnpcwmd/XLQTKwNwbS
 HUS1OC9f6YC4uqdYUZOzK3xLGAghQoKupPFmmhLWL3uQJCNlzDCqcpzmL
 HmvqXCG65EAkpGXtL2a7eGq5c73OVpwhQ5TMCDYiLd49/JDsO+1kwj1Aa
 oCXYKrf/KAvdT9mplyPzbQyxmR2qmrS2v0yYyLDDqZhKytILtlZXCcVd5
 K6f6BTo40jVW3731s6A1Fzdp8zLRs9/T0nLE8bPvERzmCopI+BhrxhrLA g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="243716121"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="243716121"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 02:58:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; d="scan'208";a="527811351"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 02:58:56 -0700
Date: Fri, 15 Apr 2022 02:59:32 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YllCBJ3nyHMrUW5v@fyu1.sc.intel.com>
References: <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
Cc: jean-philippe <jean-philippe@linaro.org>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

Hi, Dave,

On Tue, Apr 12, 2022 at 07:39:10AM -0700, Dave Hansen wrote:
> On 4/12/22 06:41, Fenghua Yu wrote:
> >> master process quit, mmput ->=A0 mm_pasid_drop->ioasid_free
> >> But this ignore driver's iommu_sva_unbind_device function,
> >> iommu_sva_bind_device and iommu_sva_unbind_device are not pair,=A0 So =
driver
> >> does not know ioasid is freed.
> >>
> >> Any suggestion?
> > ioasid is per process or per mm. A daemon process shouldn't share the s=
ame =

> > ioasid with any other process with even its parent process. Its parent =
gets
> > an ioasid and frees it on exit. The ioasid is gone and shouldn't be used
> > by its child process.
> > =

> > Each daemon process should call driver -> iommu_sva_bind_device -> ioas=
id_alloc
> > to get its own ioasid/PASID. On daemon quit, the ioasid is freed.
> > =

> > That means nqnix needs to be changed.
> =

> Fenghua, please step back for a second and look at what you are saying.
>  Your patch caused userspace to break.  Now, you're telling someone that
> they need to go change that userspace to work around something that your
> patch.  How, exactly, are you suggesting that nginx could change to fix
> this?  What, specifically, was it doing with *fork()* that was wrong?
> =

> It sounds to me like you're saying that it's OK to break userspace.

You are right. The patch should not break userspace. I follow your
suggestion to fix the issue by mmget() in binding and mmput() in unbinding.
The RFC patch was sent out in another thread. Please review it.

Thank you very much for your advice.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
