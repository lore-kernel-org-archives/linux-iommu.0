From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Date: Wed, 17 Apr 2019 10:49:26 -0600
Message-ID: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190417161042.GA43453-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dave Hansen <dave-gkUM19QKKo4@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, deepa.srinivasan-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, tycho-E0fblnxP3wo@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andrew.cooper3-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tyhicks-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Juerg Haefliger <juerg.haefliger-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linu
List-Id: iommu@lists.linux-foundation.org

On 4/17/19 10:15 AM, Ingo Molnar wrote:
> 
> [ Sorry, had to trim the Cc: list from hell. Tried to keep all the 
>   mailing lists and all x86 developers. ]
> 
> * Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> From: Juerg Haefliger <juerg.haefliger-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
