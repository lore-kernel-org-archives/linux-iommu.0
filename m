From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] xtensa: use generic dma_noncoherent_ops
Date: Wed, 11 Jul 2018 11:06:33 -0700
Message-ID: <CAMo8BfLe6YDfkYQ6HCR4xy9Refbs6zWx5KLemHnKMNP24j_z-Q@mail.gmail.com>
References: <20180619070316.26327-1-hch@lst.de>
	<CAMo8BfKzV6fhANk=ymsWFWoVtsYq3wXh559==rfjG2FimEC3+g@mail.gmail.com>
	<20180711180040.GA4262@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180711180040.GA4262-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 11, 2018 at 11:00 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> On Wed, Jul 11, 2018 at 10:57:30AM -0700, Max Filippov wrote:
>> >  config XTENSA
>> >         def_bool y
>> >         select ARCH_NO_COHERENT_DMA_MMAP if !MMU
>> > +       select ARCH_HAS_SYNC_DMA_FOR_CPU
>> > +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>>
>> This breaks alphabetical order of selects. Otherwise LGTM.
>> Sorry for the delay.
>> Acked-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Will you submit it further or should I take it into the xtensa tree?
>
> Either way is fine with me, just let me know which way you prefer.

I'll take it then. Thank you!

-- Max
