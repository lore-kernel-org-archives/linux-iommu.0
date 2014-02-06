From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: IOMMU DMA-mapping API for arm64 ?
Date: Thu, 6 Feb 2014 17:29:05 +0530
Message-ID: <CAD15agYxb8Hq3CT6Oac-X9=LQWMYkTfhHYDm2N-hP5xq5ZRWJg@mail.gmail.com>
References: <CAD15agaA9c1+0svk_d97ZEcaOg6x_PGcbKVHM9dWAZ_t1T8FXw@mail.gmail.com>
	<CAD15agbDSH4dQ8aDsW7hXZE_6Bfmpc1WrqhH2Bx0Fuy-eQUfbQ@mail.gmail.com>
	<20140206101345.GC28555@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140206101345.GC28555-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 6, 2014 at 3:43 PM, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Feb 06, 2014 at 05:21:53AM +0000, Ritesh Harjani wrote:
>> I also saw one mail discussion between you guys on what is the best place for
>> adding iommu support in ARM64, but couldn't see any followed up patches for the
>> same.
>
> The decision was to make take the iommu code from arch/arm and turn it
> into a library similar to swiotlb which can be used by the arch code. It
> is on our to-do list but no ETA yet. If you volunteer to help it would
> be great ;)

Sure Catalin, will take out the common code from arch/arm and put into
lib/iommu-helper which is the best place as discussed in many mail
chains.
Let me see how far I can go. Will keep you posted.

>
> --
> Catalin

Thanks
Ritesh
