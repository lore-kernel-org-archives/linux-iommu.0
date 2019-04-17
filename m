Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61106C282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 16:50:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2285A20835
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSc54vhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2285A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF21111F7;
	Wed, 17 Apr 2019 16:50:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 42EA211E5
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:50:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCA4A878
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 16:50:51 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3HGnG3X054958; Wed, 17 Apr 2019 16:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=Pt0iK48BFNYGn2PcXPZIgKCS+ChPFURYRr28gHDNt5M=;
	b=QSc54vhjKse2Gq1rcTB1KDv+n5ZNYuiktD723uSnPsQg7/lU0erFzUS/U+FBFZ5v5LN9
	4iDgkm0iqKmiYtxwHEIhhS/dZpybhW0dtoiBsKHfsRiNS/33zdpDmnSeEYaMYsWJC471
	dCGjeqzxijoOujPRbY2v3RHQK3LQ0lDNqJDLxAdspRBmSrV8REgdAzENjYqfKctb9EN3
	ONxMYYcd+On4oXsuj8M0FhxjRbw/Mu/K0czjCGbHDVfpbP3Gtg6t7AiiaqxMW+yFQXEF
	2d2DLE521La9q/IPFvG820wM8B3HmquyOp/lJk9noCrcYUs7OpW7XPbO3bgHsYkbl4gL
	UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rvwk3v9bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 16:49:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3HGmQda049331; Wed, 17 Apr 2019 16:49:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rv2tvg02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 16:49:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3HGnUSU030371;
	Wed, 17 Apr 2019 16:49:30 GMT
Received: from [10.65.150.207] (/10.65.150.207)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 17 Apr 2019 09:49:29 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Ingo Molnar <mingo@kernel.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Date: Wed, 17 Apr 2019 10:49:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417161042.GA43453@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904170113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904170113
Cc: Dave Hansen <dave@sr71.net>, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws,
	x86@kernel.org, iommu@lists.linux-foundation.org,
	jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, konrad.wilk@oracle.com,
	jcm@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, boris.ostrovsky@oracle.com,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
	tyhicks@canonical.com, linux-security-module@vger.kernel.org,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, dwmw@amazon.co.uk
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
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190417164926.uqHg84r_MHxdVlA95-Bsbyts9zgAlNQKhTwScXx4zPs@z>

On 4/17/19 10:15 AM, Ingo Molnar wrote:
> 
> [ Sorry, had to trim the Cc: list from hell. Tried to keep all the 
>   mailing lists and all x86 developers. ]
> 
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>> From: Juerg Haefliger <juerg.haefliger@canonical.com>
>>
>> This patch adds basic support infrastructure for XPFO which protects 
>> against 'ret2dir' kernel attacks. The basic idea is to enforce 
>> exclusive ownership of page frames by either the kernel or userspace, 
>> unless explicitly requested by the kernel. Whenever a page destined for 
>> userspace is allocated, it is unmapped from physmap (the kernel's page 
>> table). When such a page is reclaimed from userspace, it is mapped back 
>> to physmap. Individual architectures can enable full XPFO support using 
>> this infrastructure by supplying architecture specific pieces.
> 
> I have a higher level, meta question:
> 
> Is there any updated analysis outlining why this XPFO overhead would be 
> required on x86-64 kernels running on SMAP/SMEP CPUs which should be all 
> recent Intel and AMD CPUs, and with kernel that mark all direct kernel 
> mappings as non-executable - which should be all reasonably modern 
> kernels later than v4.0 or so?
> 
> I.e. the original motivation of the XPFO patches was to prevent execution 
> of direct kernel mappings. Is this motivation still present if those 
> mappings are non-executable?
> 
> (Sorry if this has been asked and answered in previous discussions.)

Hi Ingo,

That is a good question. Because of the cost of XPFO, we have to be very
sure we need this protection. The paper from Vasileios, Michalis and
Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
and 6.2.

Thanks,
Khalid


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
