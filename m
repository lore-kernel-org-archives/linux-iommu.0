From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] arm64: iommu: Refactoring common code.
Date: Wed, 12 Mar 2014 10:05:50 +0530
Message-ID: <CAD15agbG-3o33rqvmFU5xqEra321k1yTtZ_j5UDpnr1E=diH2w@mail.gmail.com>
References: <CAD15agbWL0A_vO4Osgi=uC1JxkMQgL3gshU3Z7euZf5eVaU0VA@mail.gmail.com>
	<201403111736.22104.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201403111736.22104.arnd-r2nGTMty4D4@public.gmane.org>
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
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Sure Arnd and Catalin,

Will do it by today.

On Tue, Mar 11, 2014 at 10:06 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Monday 10 March 2014, Ritesh Harjani wrote:
>>
>> Hi Everyone,
>>
>> Please find the following patch as refactoring of the common code out
>> from arch/arm/mm/dma-mapping.c to lib/iommu-helper.c
>>
>> This is just an initial version of patch to get more details and to
>> know if this is how we want to plan refactoring iommu code to
>> lib/iommu-helper.
>>
>> Please let me know the changes/suggestion which you think in this ?
>>
>
> I find this hard to review. Can you try splitting it up into two patches,
> where the first one rearranges the code with minimum moves, and the
> second just moves unmodified functions to the new file?
>
> For the changes to be useful, I think we need to move more code
> into iommu-helper.c, and I would personally prefer to drop the
> 'lib_' prefix.
>
>         Arnd
