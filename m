Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37552C4360F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:47:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FBF21855
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sUuIMJJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FBF21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2D9D22C6;
	Fri,  5 Apr 2019 15:47:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1135722C1
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:46:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9A24BFD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:46:22 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35FhrLK026668; Fri, 5 Apr 2019 15:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=aW5eO1Y1EqwbPPw39yD2qVZTCtUucALBP6ZcE8RoydE=;
	b=sUuIMJJ70LKZCsyXOAF45n8HvPFH4UW3fh0oycGVdLivZfpUXrUw1KKLCZi785NH89m/
	yApQkgSt3xhCZmm01LdEACVxdeUxXM18nHTYZcoTlnr+cHKNyHVcqMjlD29JSn5qSLS0
	2Z5O2MFRjQeGU3kRhNzkohxnVzJHX88G4/32Dm7SCP7syRYYwk35b7UJl2beMBOAc1Ua
	w8u5dZYY01gtoKQJ1G0Kn0CVKjrKdR3MtCLcd1jtAMGcJPHAqUBcLk/2/Mi8NVr9OjC7
	bcsVzP/Tj8DTC7eMxmKZ2WySnfdXWQKPXogVEL4yGagQ7+bCNrr830/w/gUmWEgKVBsK
	dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2rj13qnjdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 15:45:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35FhQPb044273; Fri, 5 Apr 2019 15:45:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2rp35rxevv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 15:45:00 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x35FidGg024942;
	Fri, 5 Apr 2019 15:44:39 GMT
Received: from [192.168.1.16] (/24.9.64.241)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 05 Apr 2019 08:44:38 -0700
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <c17d5528-59a9-411a-ac1a-58af0b4def60@oracle.com>
Date: Fri, 5 Apr 2019 09:44:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904050106
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904050107
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, steven.sistare@oracle.com,
	Christoph Hellwig <hch@lst.de>, Tycho Andersen <tycho@tycho.ws>,
	Andi Kleen <ak@linux.intel.com>, aneesh.kumar@linux.ibm.com,
	James Morris <jmorris@namei.org>,
	David Rientjes <rientjes@google.com>, anthony.yznaga@oracle.com,
	Rik van Riel <riel@surriel.com>, Nicholas Piggin <npiggin@gmail.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
	arunks@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>, brgl@bgdev.pl,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	jsteckli@amazon.de, Joerg Roedel <jroedel@suse.de>,
	Kees Cook <keescook@google.com>, zhangshaokun@hisilicon.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Aaron Lu <aaron.lu@intel.com>,
	Steve Capper <steve.capper@arm.com>, James Morse <james.morse@arm.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Michal Hocko <mhocko@suse.cz>, alexander.h.duyck@linux.intel.com,
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	kanth.ghatraju@oracle.com, Huang Ying <ying.huang@intel.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ben Hutchings <ben@decadent.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>,
	Arnd Bergmann <arnd@arndb.de>, Andrey Konovalov <andreyknvl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>, osalvador@suse.de,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	iommu@lists.linux-foundation.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Logan Gunthorpe <logang@deltatee.com>, Roman Gushchin <guro@fb.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com,
	cpandya@codeaurora.org, X86 ML <x86@kernel.org>,
	yaojun8558363@gmail.com, Ingo Molnar <mingo@redhat.com>,
	Jon Masters <jcm@redhat.com>, thymovanbeers@gmail.com,
	Laura Abbott <labbott@redhat.com>, pradeep.vincent@oracle.com,
	pavel.tatashin@microsoft.com, Jann Horn <jannh@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jim Mattson <jmattson@google.com>,
	Juergen Gross <jgross@suse.com>, marco.antonio.780@gmail.com,
	yang.shi@linux.alibaba.com, Juerg Haefliger <juergh@gmail.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tyler Hicks <tyhicks@canonical.com>, John Haxby <john.haxby@oracle.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, liran.alon@oracle.com,
	Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20190405154432.RdzZmpODQH9MazUcaIVBj3vg0uVCSvQZBH6oR4HsKVQ@z>

On 4/5/19 8:44 AM, Dave Hansen wrote:
> On 4/5/19 12:17 AM, Thomas Gleixner wrote:
>>> process. Is that an acceptable trade-off?
>> You are not seriously asking whether creating a user controllable ret2dir
>> attack window is a acceptable trade-off? April 1st was a few days ago.
> 
> Well, let's not forget that this set at least takes us from "always
> vulnerable to ret2dir" to a choice between:
> 
> 1. fast-ish and "vulnerable to ret2dir for a user-controllable window"
> 2. slow and "mitigated against ret2dir"
> 
> Sounds like we need a mechanism that will do the deferred XPFO TLB
> flushes whenever the kernel is entered, and not _just_ at context switch
> time.  This permits an app to run in userspace with stale kernel TLB
> entries as long as it wants... that's harmless.

That sounds like a good idea. This TLB flush only needs to be done at
kernel entry when there is a pending flush posted for that cpu. What
this does is move the cost of TLB flush from next context switch to
kernel entry and does not add any more flushes than what we are doing
with these xpfo patches. So the overall performance impact might not
change much. It seems worth coding up.

Thanks,
Khalid

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
