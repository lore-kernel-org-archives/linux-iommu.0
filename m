From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linux-4.19] ThinkPad T470 not booting with "intel_iommu=on"
Date: Mon, 24 Sep 2018 11:17:40 +0200
Message-ID: <CA+icZUU-=KB_KfSkfkogqALX1CF9LSc0mpahEYw9Y_frnE=_XQ@mail.gmail.com>
References: <8esCLk0ZQi6fiXhFsoyacxQLvxGN9WlaudFeER-vkxD75O5tChbEykaZCvyDoSoP0TLD9ePd12_vDWH-KJsAQraYEW8W_xIvhwD9VpCtBCA=@protonmail.ch>
	<CA+icZUWcD1naAdGb0hX6vQYevjRbMua8W9BR8_bcUS6KEVmzxA@mail.gmail.com>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+icZUWcD1naAdGb0hX6vQYevjRbMua8W9BR8_bcUS6KEVmzxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jordan Glover <Golden_Miller83-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org>
Cc: "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, "kyle.d.pelton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kyle.d.pelton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Sep 22, 2018 at 5:58 PM, Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Sep 22, 2018 at 1:40 PM, Jordan Glover
> <Golden_Miller83-g/b1ySJe57IkP3XJZ0H8fw@public.gmane.org> wrote:
>> Hi,
>>
>> This is already reported at:
>> https://bugs.freedesktop.org/show_bug.cgi?id=107783
>>
>> There is also patch posted which fixes this issue:
>> https://lore.kernel.org/patchwork/patch/983690/
>>
>> Unfortunately that patch wasn't merged yet for unknown reasons.
>>
>
> Patch "[v2,1/1] iommu/vt-d: Handle memory shortage on pasid table
> allocation" fixes the issue for me.
>
> Tested-by: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Thanks, Jordan.
>

[ CC Joerg ]

In linux-iommu Git I am not seeing this patch.
Hope this gets in soon.

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/
