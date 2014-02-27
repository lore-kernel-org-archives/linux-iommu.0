From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Thu, 27 Feb 2014 10:45:38 +0530
Message-ID: <CAD15agaps45rZT5ko9JKP2CfRF_iTV+0JMDwa239ExgKrRzBYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Everyone,

I was going through some iommu code in arch/arm and of some other
archs code. I have some doubts on this for refactoring and may need
some suggestions from you guys.

1. So, looking at other arch code, looks like they have their
different way of implementation of iova management and buffer
allocation. So to refactor the iommu common code out from arch/arm/ to
lib/iommu-helper, do we need to take care across all arch  ?

2. Should the approach be like take the common code(between arm/arm64)
and move it into lib/iommu-helper.c ?

Could someone give an example of what sort of code(will be better if
this is little more specific) we are talking here to be taken out to
lib/iommu-helper.c ? Earlier I was thinking of iova management can be
taken out but then I saw it might not be suited across all archs.

I am ready to do this work, but need some guidance from the experts .



Thanks
Ritesh






On Thu, Feb 6, 2014 at 5:29 PM, Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Feb 6, 2014 at 3:43 PM, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org> wrote:
>> On Thu, Feb 06, 2014 at 05:21:53AM +0000, Ritesh Harjani wrote:
>>> I also saw one mail discussion between you guys on what is the best place for
>>> adding iommu support in ARM64, but couldn't see any followed up patches for the
>>> same.
>>
>> The decision was to make take the iommu code from arch/arm and turn it
>> into a library similar to swiotlb which can be used by the arch code. It
>> is on our to-do list but no ETA yet. If you volunteer to help it would
>> be great ;)
>
> Sure Catalin, will take out the common code from arch/arm and put into
> lib/iommu-helper which is the best place as discussed in many mail
> chains.
> Let me see how far I can go. Will keep you posted.
>
>>
>> --
>> Catalin
>
> Thanks
> Ritesh
