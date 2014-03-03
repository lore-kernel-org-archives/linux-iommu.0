From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Mon, 3 Mar 2014 09:51:41 +0530
Message-ID: <CAD15agYW=x9E1d=ASv1Zqh8jOZ3duySJJBWitUoOG78ALqk26Q@mail.gmail.com>
References: <CAD15agaps45rZT5ko9JKP2CfRF_iTV+0JMDwa239ExgKrRzBYQ@mail.gmail.com>
	<201402272006.51057.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201402272006.51057.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Vikram MP <mp.vikram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Vinayak Menon <menon.vinayak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Nagachandra P <nagachandra-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thanks Will and Arnd for clarifying this.

The arch specific stuffs i.e. cache maintainance operations was
something even I wanted to get clarity on.
Let me get back with a raw patch based on your suggestions.

Thanks
Ritesh




On Fri, Feb 28, 2014 at 12:36 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Thursday 27 February 2014, Ritesh Harjani wrote:
>> Hi Everyone,
>>
>> I was going through some iommu code in arch/arm and of some other
>> archs code. I have some doubts on this for refactoring and may need
>> some suggestions from you guys.
>>
>> 1. So, looking at other arch code, looks like they have their
>> different way of implementation of iova management and buffer
>> allocation. So to refactor the iommu common code out from arch/arm/ to
>> lib/iommu-helper, do we need to take care across all arch  ?
>
> I'd say not initially. The code can easily live in a generic place
> but not be shared by everyone. If it turns out that another architecture
> has a better allocator, then we can always change the common code
> later.
>
>> 2. Should the approach be like take the common code(between arm/arm64)
>> and move it into lib/iommu-helper.c ?
>>
>> Could someone give an example of what sort of code(will be better if
>> this is little more specific) we are talking here to be taken out to
>> lib/iommu-helper.c ? Earlier I was thinking of iova management can be
>> taken out but then I saw it might not be suited across all archs.
>>
>> I am ready to do this work, but need some guidance from the experts .
>
> I think we should start by splitting out the iommu_coherent_ops structure
> and everything that depends on. Noncoherent DMA is harder to do in
> an architecture independent way, since we don't have a common way
> to manage the cache across architectures. It would also be good
> to follow the example of include/linux/swiotlb.h regarding the
> public interface, to keep that part common. This way, ARM can easily
> implement the noncoherent ops on top.
>
> I would leave the iova management as implementation details and
> not make that visible to architectures in the header file.
>
>         Arnd
