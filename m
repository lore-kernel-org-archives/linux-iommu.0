From: David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug: Freeing dma regions
Date: Wed, 2 Mar 2016 11:40:04 +0300
Message-ID: <CABdVeABM7OzGWeoXo1uui7f0HyP9wVLCPsEe+LnXrWXcmt7dVg@mail.gmail.com>
References: <CABdVeACY5dWoj-q4uMUnc-NgqqShemunLU1bbvLpAN6jPdBC+w@mail.gmail.com>
	<20160302082940.GS22747@8bytes.org>
	<CABdVeAB4C2aDGSgmCnGOjSzSZZ3Er5gu-ngsSVPc_XbBxsVaTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CABdVeAB4C2aDGSgmCnGOjSzSZZ3Er5gu-ngsSVPc_XbBxsVaTA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>, Valentine Sinitsyn <valentine.sinitsyn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 2, 2016 at 11:37 AM, David Kiarie <davidkiarie4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Mar 2, 2016 at 11:29 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> On Wed, Mar 02, 2016 at 03:45:39AM +0300, David Kiarie wrote:
>>> Hello,
>>>
>>> This patch seems to have introduced a bug -
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4eeca8c5e72fad752eba9efc293c924d65faa86e
>>>
>>> As the commit message says, it should check for regions behind the
>>> next_bit but it checks for regions beyond.
>>
>> Hmm, the patch looks good to me. Do you actually see a reproducible
>> issue with it?
>
> Yep,  I can't tell what exactly is happening but it seems to break
> Qemu emulated IOMMU. I haven't tried on real hardware.

What effect is setting the value next_bit to last invalidated index
supposed to have ?

>
>>
>>
>>         Joerg
>>
