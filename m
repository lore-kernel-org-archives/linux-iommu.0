Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1856C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 19:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32E9581351;
	Tue, 10 May 2022 19:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRMr9xm6m1AY; Tue, 10 May 2022 19:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DEA5A8125B;
	Tue, 10 May 2022 19:07:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5CBFC0032;
	Tue, 10 May 2022 19:07:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C54DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 19:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF2E540AF6
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 19:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=hpe.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ilaqX2ALEL-o for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 19:07:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B05E040AAD
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 19:07:04 +0000 (UTC)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AJ4gjm012605;
 Tue, 10 May 2022 19:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=mhRPpgk7nWGY4A6HlKhZOSFnmi/jRL/Ly0+izj8z7nE=;
 b=aaZc3yZ8lNcPA4E73g1YxILRVqX2LrzMhD0NdW9qfxANqC+gAj5BGBmYGWtWE8ChO/2e
 VG+Vaf6z2LKVf1mYp3ic8y4/x57XAL13d+8E8AsA+yPnd1o3ZIrlgvr80ZRttYiI2kCc
 k8cm+AFw8vVpstT6VM5s04xdypi2nae4oicptWgvKmLAudS58niBKUDwy34c6aBqEMJs
 wMpVPcSA4y46jCByCq6PyaBbvnIPTtbm1E1nbZAzvxnG29OudrHv/3c75uyT6vrHD+V2
 pYkDwqE0zTiw7sAWtu1UBv+sTmmia3HgBdpSu7zOdytfT6IXJVxqsZvjQWSPn61sqs0W Mw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com
 [15.241.140.73])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fypmkvf42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 May 2022 19:06:41 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net
 [16.220.97.129])
 by g4t3427.houston.hpe.com (Postfix) with ESMTP id 1393C5E;
 Tue, 10 May 2022 19:06:40 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [10.207.233.204])
 by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 028D04B;
 Tue, 10 May 2022 19:06:37 +0000 (UTC)
Date: Tue, 10 May 2022 14:06:37 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Message-ID: <Ynq3vRhBWZxImPC0@swahl-home.5wahls.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <636a680eb85aded76dd765ba297347ceadc3d1a4.camel@infradead.org>
 <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
 <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: X1gW75lflYtXFEMHNsqGoidFXE8ifggL
X-Proofpoint-GUID: X1gW75lflYtXFEMHNsqGoidFXE8ifggL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_06,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100081
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Rodel, Jorg" <jroedel@suse.de>,
 "Anderson, Russ" <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
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

On Tue, May 10, 2022 at 01:16:26AM +0000, Tian, Kevin wrote:
> > From: Steve Wahl <steve.wahl@hpe.com>
> > Sent: Friday, May 6, 2022 11:26 PM
> > =

> > On Fri, May 06, 2022 at 08:12:11AM +0000, Tian, Kevin wrote:
> > > > From: David Woodhouse <dwmw2@infradead.org>
> > > > Sent: Friday, May 6, 2022 3:17 PM
> > > >
> > > > On Fri, 2022-05-06 at 06:49 +0000, Tian, Kevin wrote:
> > > > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > > >
> > > > > > > --- a/include/linux/dmar.h
> > > > > > > +++ b/include/linux/dmar.h
> > > > > > > @@ -19,7 +19,7 @@
> > > > > > >   struct acpi_dmar_header;
> > > > > > >
> > > > > > >   #ifdef	CONFIG_X86
> > > > > > > -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > > > > > +# define	DMAR_UNITS_SUPPORTED	640
> > > > > > >   #else
> > > > > > >   # define	DMAR_UNITS_SUPPORTED	64
> > > > > > >   #endif
> > > > >
> > > > > ... is it necessary to permanently do 10x increase which wastes m=
emory
> > > > > on most platforms which won't have such need.
> > > >
> > > > I was just looking at that. It mostly adds about 3=BD KiB to each s=
truct
> > > > dmar_domain.
> > > >
> > > > I think the only actual static array is the dmar_seq_ids bitmap whi=
ch
> > > > grows to 640 *bits* which is fairly negligible, and the main growth=
 is
> > > > that it adds about 3=BD KiB to each struct dmar_domain for the
> > > > iommu_refcnt[] and iommu_did[] arrays.
> > >
> > > Thanks for the quick experiment! though the added material is
> > > negligible it's cleaner to me if having a way to configure it as
> > > discussed below.
> > >
> > > >
> > > > > Does it make more sense to have a configurable approach similar to
> > > > > CONFIG_NR_CPUS? or even better can we just replace those static
> > > > > arrays with dynamic allocation so removing this restriction
> > > > > completely?
> > > >
> > > > Hotplug makes that fun, but I suppose you only need to grow the arr=
ay
> > > > in a given struct dmar_domain if you actually add a device to it th=
at's
> > > > behind a newly added IOMMU. I don't know if the complexity of makin=
g it
> > > > fully dynamic is worth it though. We could make it a config option,
> > > > and/or a command line option (perhaps automatically derived from
> > > > CONFIG_NR_CPUS).
> > >
> > > either config option or command line option is OK to me. Probably
> > > the former is simpler given no need to dynamically expand the
> > > static array. btw though deriving from CONFIG_NR_CPUS could work
> > > in this case it is unclear why tying the two together is necessary in
> > > concept, e.g. is there guarantee that the number of IOMMUs must
> > > be smaller than the number of CPUs in a platform?
> > >
> > > >
> > > > If it wasn't for hotplug, I think we'd know the right number by the
> > > > time we actually need it anyway, wouldn't we? Can we have a heurist=
ic
> > > > for how many DMAR units are likely to be hotplugged? Is it as simpl=
e as
> > > > the ratio of present to not-yet-present CPUs in MADT?
> > >
> > > Probably. But I don't have enough knowledge on DMAR hotplug to
> > > judge (e.g. whether it's strictly tied to CPU hotplug and if yes whet=
her
> > > there could be multiple IOMMUs hotplugged together with a CPU
> > > socket)...
> > >
> > > Thanks
> > > Kevin
> > =

> > Would anyone be more comfortable if we only increase the limit where
> > MAXSMP is set?
> > =

> > i.e.
> > =

> > #if defined(CONFIG_X86) && defined(CONFIG_MAXSMP)
> > # define	DMAR_UNITS_SUPPORTED	640
> > #elif defined(CONFIG_X86)
> > # define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > #else
> > # define	DMAR_UNITS_SUPPORTED	64
> > #endif
> > =

> > Thank you all for your time looking at this.
> > =

> =

> This works for your own configuration but it's unclear whether other
> MAXSMP platforms have the exact same requirements (different
> number of sockets, different ratio of #iommus/#sockets, etc.). In any
> case since we are at it having a generic way to extend it makes more
> sense to me.

So, to be clear, what you would like to see would be Kconfig entries
to create a config option, say "NR_DMARS", set up so the default is:

     MAXSMP?  640
     X86_64?  128
     X86_32?  64
     other    64

And DMAR_UNITS_SUPPORTED gets removed, and everywhere it was used we
use CONFIG_NR_DMARS in its place?

I can give that a shot but wanted to confirm this is what you'd want
first.

Thanks,

--> Steve

-- =

Steve Wahl, Hewlett Packard Enterprise
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
