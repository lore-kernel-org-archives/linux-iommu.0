Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890FDC282DA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:33:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A8420821
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hHbyQcR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A8420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0FD27C8B;
	Wed, 17 Apr 2019 17:33:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1DD61B65
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:33:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 96EC186F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:33:53 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3HHO5lG087083; Wed, 17 Apr 2019 17:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=n6AW0KFZfBWQXIF3BLuGRaqvWHMs7VP7kbUpQyzZLCQ=;
	b=hHbyQcR+kqdRDbS1HXGo+9Imp9OxI6FtwGiqAsx93fBWBDk7CX4jIet+aGdG1y6ekO8C
	Ti2Do+GqJOBrEB5x67xr+rylVhRtLSeWIi9OyRLpnSoEJ7MlPeL6aVzmxNJeu5NT+0V1
	BY9E+QKXPaHaEI9l3DsywXK8Nwo+WtmwCh/ApxHEC5zeBkDVLjReK64fxhjMPnODAvgB
	BwCVpKk3nhXq1aNu8Vhevz8BvIfHlKJN4MJ+qs43AbfU/nYZ0/Hdd7eOfR2rrofEznbE
	AbhTNE7XqQeWKp1Di9iYW9dQmATPYclZx6QHSHuLjZEw77+iY0XumcJRb03aj+gUI3WP
	Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2rvwk3vhf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 17:33:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3HHWBSB165901; Wed, 17 Apr 2019 17:33:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2rv2tvgqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2019 17:33:09 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3HHX7ls006927;
	Wed, 17 Apr 2019 17:33:07 GMT
Received: from [192.168.1.16] (/24.9.64.241)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 17 Apr 2019 10:33:07 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Ingo Molnar <mingo@kernel.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
Date: Wed, 17 Apr 2019 11:33:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417170918.GA68678@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904170117
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904170117
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
Message-ID: <20190417173303.Fwe3wlz645fjK6HEi_6rVCBb4K7ZkJCZ1qQxomnYKOw@z>

On 4/17/19 11:09 AM, Ingo Molnar wrote:
> 
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
>>> I.e. the original motivation of the XPFO patches was to prevent execution 
>>> of direct kernel mappings. Is this motivation still present if those 
>>> mappings are non-executable?
>>>
>>> (Sorry if this has been asked and answered in previous discussions.)
>>
>> Hi Ingo,
>>
>> That is a good question. Because of the cost of XPFO, we have to be very
>> sure we need this protection. The paper from Vasileios, Michalis and
>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
>> and 6.2.
> 
> So it would be nice if you could generally summarize external arguments 
> when defending a patchset, instead of me having to dig through a PDF 
> which not only causes me to spend time that you probably already spent 
> reading that PDF, but I might also interpret it incorrectly. ;-)

Sorry, you are right. Even though that paper explains it well, a summary
is always useful.

> 
> The PDF you cited says this:
> 
>   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
>    in many platforms, including x86-64.  In our example, the content of 
>    user address 0xBEEF000 is also accessible through kernel address 
>    0xFFFF87FF9F080000 as plain, executable code."
> 
> Is this actually true of modern x86-64 kernels? We've locked down W^X 
> protections in general.
> 
> I.e. this conclusion:
> 
>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and 
>    triggering the kernel to dereference it, an attacker can directly 
>    execute shell code with kernel privileges."
> 
> ... appears to be predicated on imperfect W^X protections on the x86-64 
> kernel.
> 
> Do such holes exist on the latest x86-64 kernel? If yes, is there a 
> reason to believe that these W^X holes cannot be fixed, or that any fix 
> would be more expensive than XPFO?

Even if physmap is not executable, return-oriented programming (ROP) can
still be used to launch an attack. Instead of placing executable code at
user address 0xBEEF000, attacker can place an ROP payload there. kfptr
is then overwritten to point to a stack-pivoting gadget. Using the
physmap address aliasing, the ROP payload becomes kernel-mode stack. The
execution can then be hijacked upon execution of ret instruction. This
is a gist of the subsection titled "Non-executable physmap" under
section 6.2 and it looked convincing enough to me. If you have a
different take on this, I am very interested in your point of view.

Thanks,
Khalid


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
