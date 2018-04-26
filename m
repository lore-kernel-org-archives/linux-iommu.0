From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Boot hangs with "AMD-Vi Command Buffer Timeout"
Date: Thu, 26 Apr 2018 17:22:33 +0200
Message-ID: <20180426152233.GP15462@8bytes.org>
References: <CAKzrAgQN-qML3-kheKxwAH3aUwny5UNp1vcDKAEEuh0S+4hyTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKzrAgQN-qML3-kheKxwAH3aUwny5UNp1vcDKAEEuh0S+4hyTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ojab // <ojab-uv7J75MkRmE@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I've added some AMD people to Cc. Suravee, Tom, any ideas here? One of
the screen-shots behind the link below show IOTLB_INV_TIMEOUT errors, so
it is likely ATS related. Maybe you guys can reproduce it on your side?


Thanks,

	Joerg


On Thu, Apr 26, 2018 at 10:28:47AM +0000, ojab // wrote:
> I've made a bugzilla issue [1] about it, but I'm not sure if anyone
> reading bugzilla reports, so duplicating here.
> I have raven ridge APU (2400g) + ASUS A320M-K motherboard and boot
> (4.16.4 & 4.17-rc2) hangs printing many `[    0.001000] AMD-Vi Command
> Buffer Timeout` messages. With IOMMU disabled (either via EFI/BIOS or
> using amd_iommu=off) it boots fine.
> 
> What info is needed to debug/fix it?
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=199513
> 
> //wbr ojab
